using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using AirFlow.Services.Helpers;
using AirFlow.Utilities;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AuthSurfaceController : SurfaceController
    {
        private const string PartialViewLoginMessage = "/Views/Partials/Auth/_LoginMessage.cshtml";

        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;
        private readonly IAirFlowHelper _airFlowHelper;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AuthSurfaceController));

        public AuthSurfaceController(
            IAuthService authService,
            IFormsAuthentication formsAuthentication,
            IAirFlowHelper airFlowHelper)
        {
            _authService = authService;
            _formsAuthentication = formsAuthentication;
            _airFlowHelper = airFlowHelper;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Login(UserLoginViewModel loginRequest)
        {
            _logger.Debug($"Login request: '{loginRequest}'");
            if (!ModelState.IsValid)
            {
                _logger.Info("Login request is invalid");
                return PartialView(PartialViewLoginMessage, new ResultViewModel("Please, verify input data", isSuccess: false));
            }

            LoginResult loginResult = _authService.Login(new UserToLogin(loginRequest));
            _logger.Debug(loginResult.ToString());

            if (loginResult.IsFailure)
            {
                return PartialView(PartialViewLoginMessage, new ResultViewModel(loginResult.ErrorCode.ToString(), isSuccess: false));
            }

            if (loginResult.Type == LoginType.Regular)
            {
                _formsAuthentication.SetAuthCookie(loginResult.Username, createPersistentCookie: false);
                return JavaScript($"window.location = '{GetContentUrl(AirFlowConstants.HomeContent)}'");
            }

            return PartialView(PartialViewLoginMessage, new ResultViewModel("Confirmation message was sent to your email", isSuccess: true));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            string identityUser = User?.Identity?.Name;

            if (string.IsNullOrEmpty(identityUser) == false)
            {
                _formsAuthentication.SignOut();
                _logger.Debug($"Logout processed for {identityUser}'");
            }

            return RedirectToUmbracoPage(_airFlowHelper.GetContentId("Login"));
        }

        [HttpGet]
        public ActionResult ConfirmEmail(string token)
        {
            _logger.Debug($"Confirm email request: {token}'");

            if (string.IsNullOrEmpty(token))
            {
                _logger.Info("Token is null or empty");
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationFailureContent));
            }

            Result confirmationResult = _authService.ConfirmEmail(token);
            _logger.Debug(confirmationResult?.ToString());

            if (confirmationResult.IsFailure)
            {
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationFailureContent));
            }

            return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationSuccessContent));
        }

        [HttpGet]
        public ActionResult ConfirmLogin(string token)
        {
            _logger.Debug($"Confirm login request: {token}'");

            if (string.IsNullOrEmpty(token))
            {
                _logger.Info("Token is null or empty");
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.LoginConfirmationFailureContent));
            }

            LoginResult confirmationResult = _authService.ConfirmLogin(token);
            _logger.Debug(confirmationResult.ToString());

            if (confirmationResult.IsFailure)
            {
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.LoginConfirmationFailureContent));
            }

            _formsAuthentication.SetAuthCookie(confirmationResult.Username, createPersistentCookie: false);
            return RedirectToUmbracoPage(_airFlowHelper.GetContentId(AirFlowConstants.HomeContent));
        }

        private int GetContentId(string contentName)
        {
            return _airFlowHelper.GetContentId(contentName);
        }

        private string GetContentUrl(string contentName)
        {
            return _airFlowHelper.GetContentUrl(UmbracoContext, contentName);
        }
    }
}