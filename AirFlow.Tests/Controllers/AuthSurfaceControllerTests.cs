using AirFlow.Controllers;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using AirFlow.Services.Helpers;
using NUnit.Framework;
using NSubstitute;
using System;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web;
using Umbraco.Web.Mvc;

namespace AirFlow.Tests.Controllers
{
    [TestFixture]
    public class AuthSurfaceControllerTests
    {
        private const string Username = "username";
        private const int ExpectedContentId = 1;

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

            _authController = new AuthSurfaceController(_authService, _formsAuthentication, _airFlowHelper)
            {
                ControllerContext = new ControllerContext
                {
                    HttpContext = Substitute.For<HttpContextBase>()
                }
            };
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
            string homeUrl = "/";
            string expectedScript = $"window.location = '{homeUrl}'";
            UserLoginViewModel loginRequest = GetUserLoginViewModel();
            MockSuccessServiceLoginMethod(loginRequest);
            _airFlowHelper.GetContentUrl(Arg.Any<UmbracoContext>(), "Home").Returns(homeUrl);

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
            MockSuccessServiceLoginMethod(loginRequest, type: LoginType.TwoFactorViaEmail);

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
        public void AuthSurfaceController_Logout_UserWasLoggedIn_RedirectToLoginPage()
        {
            // Arrange
            ArrangeAirFlowHelper_GetContentId("Login", ExpectedContentId);

            // Act
            _authController.ControllerContext.HttpContext.User.Identity.Name.Returns("Name");
            var result = _authController.Logout() as RedirectToUmbracoPageResult;

            // Assert
            _formsAuthentication.Received(1).SignOut();
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        [Test]
        public void AuthSurfaceController_Logout_UserWasLoggedOut_RedirectToLoginPage()
        {
            // Arrange
            ArrangeAirFlowHelper_GetContentId("Login", ExpectedContentId);

            // Act
            _authController.ControllerContext.HttpContext.User.Identity.Name.Returns("");
            var result = _authController.Logout() as RedirectToUmbracoPageResult;

            // Assert
            _formsAuthentication.Received(0).SignOut();
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        #endregion

        #region Confirm Email

        private const string ValidToken = "token";

        [Test]
        public void AuthSurfaceController_ConfirmEmail_ValidToken_Success()
        {
            // Arrange
            _authService.ConfirmEmail(ValidToken).Returns(Result.Success);
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.EmailConfirmationSuccessContent, ExpectedContentId);

            // Act
            var result = _authController.ConfirmEmail(ValidToken) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        [TestCase("")]
        [TestCase(null)]
        public void AuthSurfaceController_ConfirmEmail_TokenIsMissingOrEmpty_Success(string token)
        {
            // Arrange
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.EmailConfirmationFailureContent, ExpectedContentId);

            // Act
            var result = _authController.ConfirmEmail(token) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
            _authService.ReceivedWithAnyArgs(0).ConfirmEmail(token);
        }

        [Test]
        public void AuthSurfaceController_ConfirmEmail_ConfirmationFailure_Success()
        {
            // Arrange           
            _authService.ConfirmEmail(ValidToken).Returns(new Result(ErrorCodeType.ConfirmationTokenIsExpired));
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.EmailConfirmationFailureContent, ExpectedContentId);

            // Act
            var result = _authController.ConfirmEmail(ValidToken) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        #endregion

        #region Confirm Login

        private const string LoginToken = "token";

        [Test]
        public void AuthSurfaceController_ConfirmLogin_ValidToken_RedirectToHomePage()
        {
            // Arrange
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.HomeContent, ExpectedContentId);
            _authService.ConfirmLogin(LoginToken).Returns(new LoginResult(Username, LoginType.TwoFactorViaEmail));

            // Act
            var result = _authController.ConfirmLogin(LoginToken) as RedirectToUmbracoPageResult;

            // Assert
            _formsAuthentication.Received(1).SetAuthCookie(Username, createPersistentCookie: false);
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        [TestCase("")]
        [TestCase(null)]
        public void AuthSurfaceController_ConfirmLogin_TokenIsMissingOrEmpty_RedirectToErrorPage(string token)
        {
            // Arrange
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.LoginConfirmationFailureContent, ExpectedContentId);

            // Act
            var result = _authController.ConfirmLogin(token) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
            _authService.ReceivedWithAnyArgs(0).ConfirmEmail(token);
        }

        [Test]
        public void AuthSurfaceController_ConfirmLogin_ConfirmationFailure_Success()
        {
            // Arrange           
            _authService.ConfirmLogin(LoginToken).Returns(new LoginResult(ErrorCodeType.ConfirmationTokenIsExpired));
            ArrangeAirFlowHelper_GetContentId(AirFlowConstants.LoginConfirmationFailureContent, ExpectedContentId);

            // Act
            var result = _authController.ConfirmLogin(LoginToken) as RedirectToUmbracoPageResult;

            // Assert
            Common.AssertRedirectToUmbracoPageResult(result, ExpectedContentId);
        }

        #endregion

        private void ArrangeAirFlowHelper_GetContentId(string contentName, int expectedContentPageId)
        {
            _airFlowHelper.GetContentId(contentName).Returns(expectedContentPageId);
        }
    }
}