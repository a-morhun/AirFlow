using AirFlow.Services.Auth;
using AirFlow.Controllers;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using NUnit.Framework;
using NSubstitute;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using AirFlow.Models.Account;
using AirFlow.Services.Account;
using Umbraco.Web.Mvc;

namespace AirFlow.Tests.Controllers
{
    [TestFixture]
    public class AccountControllerTests
    {
        private IAccountService _accountService;
        private IFormsAuthentication _formsAuthentication;
        private IMembership _membership;
        private AccountController _accountController;

        private string responseTypeMismatchFormat = "response is not type of {0} or missing at all";
        private string redirectUrlMismatchFormat = "Url for redirect should be {0}";
        private string errorMessagesMismatch = "error messages are not the same";

        [OneTimeSetUp]
        public void SetUpOnce()
        {
            _accountService = Substitute.For<IAccountService>();
            _formsAuthentication = Substitute.For<IFormsAuthentication>();
            _membership = Substitute.For<IMembership>();

            var request = Substitute.For<HttpRequestBase>();
            var httpContext = Substitute.For<HttpContextBase>();

            request.Cookies.Returns(new HttpCookieCollection());
            httpContext.Request.Returns(request);

            _accountController = new AccountController(_accountService, _formsAuthentication, _membership);
            _accountController.ControllerContext = new ControllerContext(httpContext, new RouteData(), _accountController);
        }

        #region Registration

        [Test]
        public void Register_ValidValtechUserInfo_RegisterAndRedirectToHomePage()
        {
            // Arrange
            string expectedRedirectUrl = "/";
            var registrationRequest = new UserRegistrationViewModel
            {
                Email = $"mock@{Common.ValtechUkDomain}",
                Password = "password",
                Username = "username"
            };

            _accountService.Register(Arg.Is<UserToRegister>(r =>
                r.Email == registrationRequest.Email &&
                r.Password == registrationRequest.Password &&
                r.Username == registrationRequest.Username))
            .Returns(new RegistrationResult(shouldAutoLogin: true));

            // Act
            RedirectResult result = _accountController.Register(registrationRequest) as RedirectResult;

            // Assert
            Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(RedirectResult).Name));
            _formsAuthentication.Received(1).SetAuthCookie(registrationRequest.Username, createPersistentCookie: false);
            Assert.AreEqual(expectedRedirectUrl, result.Url, string.Format(redirectUrlMismatchFormat, expectedRedirectUrl));
        }

        [Test]
        public void Register_ValidOtherUserInfo_RegisterAndRedirectToLoginPage()
        {
            // Arrange
            string expectedRedirectUrl = "/login";
            var registrationRequest = new UserRegistrationViewModel
            {
                Email = $"mock@other.com",
                Password = "password",
                Username = "username"
            };

            _accountService.Register(Arg.Is<UserToRegister>(r =>
                r.Email == registrationRequest.Email &&
                r.Password == registrationRequest.Password &&
                r.Username == registrationRequest.Username))
            .Returns(new RegistrationResult(shouldAutoLogin: false));

            // Act
            RedirectResult result = _accountController.Register(registrationRequest) as RedirectResult;

            // Assert
            Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(RedirectResult).Name));
            _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
            Assert.AreEqual(expectedRedirectUrl, result.Url, string.Format(redirectUrlMismatchFormat, expectedRedirectUrl));
        }

        [Test]
        public void Register_ValidUserInfoAndServiceFailedToSave_DisplayErrorMessage()
        {
            // Arrange
            var errorCode = ErrorCodeType.UnknownError;
            string expectedErrorMessage = "some error occurred";
            var registrationRequest = new UserRegistrationViewModel();

            _accountService.Register(Arg.Any<UserToRegister>()).Returns(new Result(errorCode, expectedErrorMessage));

            // Act
            ContentResult result = _accountController.Register(registrationRequest) as ContentResult;

            // Assert
            Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(ContentResult).Name));
            _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
            Assert.AreEqual(expectedErrorMessage, result.Content, errorMessagesMismatch);
        }

        [Test]
        public void Register_InvalidUserInfo_ReturnCurrentUmbracoPage()
        {
            // Arrange
            _accountController.ModelState.AddModelError("errorKey", "errorMessage");

            // Act
            UmbracoPageResult result = _accountController.Register(new UserRegistrationViewModel()) as UmbracoPageResult;

            // Assert
            Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(UmbracoPageResult).Name));
            _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
        }

        #endregion

        //#region Login

        //[Test]
        //public void Login_ValidUserInfoAndValidCredentials_LoginAndRedirectsToHomePage()
        //{
        //    // Arrange
        //    string expectedRedirectUrl = "/";
        //    string username = "username";
        //    var loginRequest = new UserLoginViewModel
        //    {
        //        Email = "some@email",
        //        Password = "password"
        //    };

        //    _membership.GetUserNameByEmail(loginRequest.Email).Returns(username);
        //    _membership.ValidateUser(username, loginRequest.Password).Returns(true);

        //    // Act
        //    RedirectResult result = _authController.Login(loginRequest) as RedirectResult;

        //    // Assert
        //    Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(RedirectResult).Name));
        //    _formsAuthentication.Received(1).SetAuthCookie(username, createPersistentCookie: false);
        //    Assert.AreEqual(expectedRedirectUrl, result.Url, string.Format(redirectUrlMismatchFormat, expectedRedirectUrl));
        //}

        //[Test]
        //public void Login_ValidUserInfoAndInvalidCredentials_ErrorMessageInContentReturned()
        //{
        //    // Arrange
        //    string expectedErrorMessage = "Invalid credentials provided";
        //    _membership.GetUserNameByEmail(Arg.Any<string>()).Returns("someusername");
        //    _membership.ValidateUser(Arg.Any<string>(), Arg.Any<string>()).Returns(false);

        //    // Act
        //    ContentResult result = _authController.Login(new UserLoginViewModel()) as ContentResult;

        //    // Assert
        //    Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(ContentResult).Name));
        //    _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
        //    Assert.AreEqual(expectedErrorMessage, result.Content, errorMessagesMismatch);
        //}

        //[Test]
        //[TestCase("")]
        //[TestCase(null)]
        //public void Login_ValidUserInfoAndUsernameDoesNotExist_ErrorMessageInContentReturned(string missingUsername)
        //{
        //    // Arrange
        //    string expectedErrorMessage = "Invalid credentials provided";
        //    _membership.GetUserNameByEmail(Arg.Any<string>()).Returns(missingUsername);

        //    // Act
        //    ContentResult result = _authController.Login(new UserLoginViewModel()) as ContentResult;

        //    // Assert
        //    Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(ContentResult).Name));
        //    _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
        //    Assert.AreEqual(expectedErrorMessage, result.Content, errorMessagesMismatch);
        //}

        //[Test]
        //public void Login_InvalidUserInfo_ReturnCurrentUmbracoPage()
        //{
        //    // Arrange
        //    _authController.ModelState.AddModelError("errorKey", "errorMessage");

        //    // Act
        //    UmbracoPageResult result = _authController.Login(new UserLoginViewModel()) as UmbracoPageResult;

        //    // Assert
        //    Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(UmbracoPageResult).Name));
        //    _formsAuthentication.Received(0).SetAuthCookie(Arg.Any<string>(), Arg.Any<bool>());
        //}

        //#endregion

        //#region Logout

        //[Test]
        //public void Logout_SuccessLogout()
        //{
        //    // Arrangee
        //    string expectedRedirectUrl = "/login";

        //    // Act
        //    RedirectResult result = _authController.Login(new UserLoginViewModel()) as RedirectResult;

        //    // Assert
        //    Assert.IsNotNull(result, string.Format(responseTypeMismatchFormat, typeof(RedirectResult).Name));
        //    _formsAuthentication.Received(1).SignOut();
        //    Assert.AreEqual(expectedRedirectUrl, result.Url, string.Format(redirectUrlMismatchFormat, expectedRedirectUrl));
        //}

        //#endregion
    }
}