using AirFlow.Services.Auth;
using AirFlow.Controllers;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using NUnit.Framework;
using NSubstitute;
using System;
using System.Linq.Expressions;
using System.Web.Mvc;
using AirFlow.ServiceContainers;
using AirFlow.Services.Helpers;
using Autofac;
using Umbraco.Core.Services;
using Umbraco.Web.Mvc;

namespace AirFlow.Tests.Controllers
{
    [TestFixture]
    public class AuthSurfaceControllerTests
    {
        private const string Username = "username";

        private IAuthService _authService;
        private IFormsAuthentication _formsAuthentication;
        private IAirFlowHelper _airFlowHelper;
        private AuthSurfaceController _authController;

        [SetUp]
        public void SetUp()
        {
            Common.SetUpUmbracoContext();

            _authService = Substitute.For<IAuthService>();
            _formsAuthentication = Substitute.For<IFormsAuthentication>();
            _airFlowHelper = Substitute.For<IAirFlowHelper>();

            _authController = new AuthSurfaceController(_authService, _formsAuthentication);

            var builder = new ContainerBuilder();
            builder.RegisterInstance(_airFlowHelper).As<IAirFlowHelper>();
            AirFlowServiceContainer.SetContainer(builder.Build());
        }

        [TearDown]
        public void TearDown()
        {
            Common.DisposeUmbracoContext();
        }

        #region Login

        [Test]
        public void AuthSurfaceController_Login_ValidLoginRequest_ValidCredentials_RegularLogin_Success()
        {
            // Arrange
            string expectedScript = "window.location = '/'";
            UserLoginViewModel loginRequest = GetUserLoginViewModel();
            MockSuccessServiceLoginMethod(loginRequest);

            // Act
            var result = _authController.Login(loginRequest) as JavaScriptResult;

            // Assert
            _formsAuthentication.Received(1).SetAuthCookie(Username, createPersistentCookie: false);
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(JavaScriptResult)));
            Assert.AreEqual(expectedScript, result.Script, Common.ShowNotSatisfiedExpectationMessage(expectedScript, "Script"));
        }

        [Test]
        public void AuthSurfaceController_Login_ValidLoginRequest_ValidCredentials_TwoFactorLogin_Success()
        {
            // Arrange
            UserLoginViewModel loginRequest = GetUserLoginViewModel();
            MockSuccessServiceLoginMethod(loginRequest, type: LoginType.TwoFactorEmail);

            // Act
            var result = _authController.Login(loginRequest) as PartialViewResult;

            // Assert
            _formsAuthentication.Received(0).SetAuthCookie(Username, createPersistentCookie: false);
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            Assert.IsTrue(model.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsSuccess"));
        }

        [Test]
        public void AuthSurfaceController_Login_ValidLoginRequest_FailedToLogin_Failure()
        {
            // Arrange
            UserLoginViewModel loginRequest = GetUserLoginViewModel();
            MockFailureServiceRegisterMethod(loginRequest, ErrorCodeType.MemberNotFound);

            // Act
            var result = _authController.Login(loginRequest) as PartialViewResult;

            // Assert
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            Assert.IsTrue(model.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsFailure"));
        }

        [Test]
        public void AuthSurfaceController_Login_InvalidRegistrationRequest_FailedToLogin_Failure()
        {
            // Arrange
            _authController.ModelState.AddModelError("error", new Exception());

            // Act
            var result = _authController.Login(Arg.Any<UserLoginViewModel>()) as PartialViewResult;

            // Assert
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            Assert.IsTrue(model.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsFailure"));
        }

        private UserLoginViewModel GetUserLoginViewModel() => new UserLoginViewModel
        {
            Email = "some@email",
            Password = "password"
        };

        private void MockSuccessServiceLoginMethod(UserLoginViewModel loginRequest, string username = Username, LoginType type = LoginType.Regular) =>
            _authService.Login(Arg.Is(ServiceLoginPredicate(loginRequest))).Returns(new LoginResult(username, type));

        private void MockFailureServiceRegisterMethod(UserLoginViewModel loginRequest, ErrorCodeType errorCode) =>
            _authService.Login(Arg.Is(ServiceLoginPredicate(loginRequest))).Returns(new LoginResult(errorCode));

        private static Expression<Predicate<UserToLogin>> ServiceLoginPredicate(UserLoginViewModel loginRequest) =>
            r => r.Email == loginRequest.Email && r.Password == loginRequest.Password;

        #endregion

        #region Logout

        [Test]
        public void AuthSurfaceController_Logout_Success()
        {
            // Arrangee
            string expectedRedirectUrl = "/login";

            // Act
            var result = _authController.Logout() as RedirectResult;

            // Assert
            _formsAuthentication.Received(1).SignOut();
            Common.AssertRedirectResult(result, expectedRedirectUrl);
        }

        #endregion

        #region Confirm Email

        private const string ValidToken = "token";

        [Test]
        public void AuthSurfaceController_ConfirmEmail_ValidToken_Success()
        {
            // Arrange
            string expectedContentName = "EmailConfirmationSuccess";
            const int expectedContentPageId = 2;
            _authService.ConfirmEmail(ValidToken).Returns(Result.Success);
            _airFlowHelper.GetContentId(expectedContentName).Returns(expectedContentPageId);

            // Act
            var result = _authController.ConfirmEmail(ValidToken) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, expectedContentPageId);
        }

        [TestCase("")]
        [TestCase(null)]
        public void AuthSurfaceController_ConfirmEmail_TokenIsMissingOrEmpty_Success(string token)
        {
            // Arrange
            string expectedContentName = "EmailConfirmationFailure";
            const int expectedContentPageId = 1;
            _airFlowHelper.GetContentId(expectedContentName).Returns(expectedContentPageId);

            // Act
            var result = _authController.ConfirmEmail(token) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, expectedContentPageId);
            _authService.ReceivedWithAnyArgs(0).ConfirmEmail(token);
        }

        [Test]
        public void AuthSurfaceController_ConfirmEmail_ConfirmationFailure_Success()
        {
            // Arrange
            string expectedContentName = "EmailConfirmationFailure";
            const int expectedContentPageId = 1;
            _authService.ConfirmEmail(ValidToken).Returns(new Result(ErrorCodeType.ConfirmationTokenIsExpired));
            _airFlowHelper.GetContentId(expectedContentName).Returns(expectedContentPageId);

            // Act
            var result = _authController.ConfirmEmail(ValidToken) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, expectedContentPageId);
        }

        #endregion

        #region Confirm Login

        private const string LoginToken = "token";

        [Test]
        public void AuthSurfaceController_ConfirmLogin_ValidToken_RedirectToHomePage()
        {
            // Arrange
            string expectedUrl = "/";
            _authService.ConfirmLogin(LoginToken).Returns(new LoginResult(Username, LoginType.TwoFactorEmail));

            // Act
            var result = _authController.ConfirmLogin(LoginToken) as RedirectResult;

            // Assert
            _formsAuthentication.Received(1).SetAuthCookie(Username, createPersistentCookie: false);
            Common.AssertRedirectResult(result, expectedUrl);
        }

        #endregion
    }
}