using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using AirFlow.Services.Helpers;
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
            if (!ModelState.IsValid)
            {
                return PartialView(PartialViewLoginMessage, new ResultViewModel("Please, verify input data", isSuccess: false));
            }

            LoginResult loginResult = _authService.Login(new UserToLogin(loginRequest));

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
        [MemberAuthorize]
        public ActionResult Logout()
        {
            _formsAuthentication.SignOut();
            return RedirectToUmbracoPage(_airFlowHelper.GetContentId("Login"));
        }

        [HttpGet]
        public ActionResult ConfirmEmail(string token)
        {
            if (string.IsNullOrEmpty(token))
            {
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationFailureContent));
            }

            Result confirmationResult = _authService.ConfirmEmail(token);

            if (confirmationResult.IsFailure)
            {
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationFailureContent));
            }

            return RedirectToUmbracoPage(GetContentId(AirFlowConstants.EmailConfirmationSuccessContent));
        }

        [HttpGet]
        public ActionResult ConfirmLogin(string token)
        {
            if (string.IsNullOrEmpty(token))
            {
                return RedirectToUmbracoPage(GetContentId(AirFlowConstants.LoginConfirmationFailureContent));
            }

            LoginResult confirmationResult = _authService.ConfirmLogin(token);

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