using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System.Web.Mvc;
using AirFlow.ServiceContainers;
using AirFlow.Services.Helpers;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AuthSurfaceController : SurfaceController
    {
        private const string PartialViewLoginMessage = "/Views/Partials/Auth/_LoginMessage.cshtml";
        private const string ConfirmationSuccessContentName = "EmailConfirmationSuccess";
        private const string ConfirmationFailureContentName = "EmailConfirmationFailure";
        private const string ViewLoginConfirmationFailure = "/Views/ConfirmLoginFailure.cshtml";
        private const string HomePath = "/";

        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;

        private IAirFlowHelper _airFlowHelper => AirFlowServiceContainer.GetInstance<IAirFlowHelper>();

        public AuthSurfaceController(
            IAuthService authService,
            IFormsAuthentication formsAuthentication)
        {
            _authService = authService;
            _formsAuthentication = formsAuthentication;
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
                return PartialView(PartialViewLoginMessage, new ResultViewModel(loginResult.ErrorCode.Value.ToString(), isSuccess: false));
            }

            if (loginResult.Type == LoginType.Regular)
            {
                _formsAuthentication.SetAuthCookie(loginResult.Username, createPersistentCookie: false);

                string homeUrl = UmbracoContext.UrlProvider.GetUrl(_airFlowHelper.GetContentId("Home"));
                return JavaScript($"window.location = '{homeUrl}'");
            }
            return PartialView(PartialViewLoginMessage, new ResultViewModel("Confirmation message was sent to your email", isSuccess: true));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MemberAuthorize]
        public ActionResult Logout()
        {
            _formsAuthentication.SignOut();
            return Redirect(HomePath);
        }

        [HttpGet]
        public ActionResult ConfirmEmail(string token)
        {
            if (string.IsNullOrEmpty(token))
            {
                return RedirectToUmbracoPage(_airFlowHelper.GetContentId(ConfirmationFailureContentName));
            }

            Result confirmationResult = _authService.ConfirmEmail(token);

            if (confirmationResult.IsFailure)
            {
                return RedirectToUmbracoPage(_airFlowHelper.GetContentId(ConfirmationFailureContentName));
            }

            return RedirectToUmbracoPage(_airFlowHelper.GetContentId(ConfirmationSuccessContentName));
        }

        [HttpGet]
        public ActionResult ConfirmLogin(string token)
        {
            if (string.IsNullOrEmpty(token))
            {
                return View(ViewLoginConfirmationFailure);
            }

            LoginResult confirmationResult = _authService.ConfirmLogin(token);

            if (confirmationResult.IsFailure)
            {
                return View(ViewLoginConfirmationFailure);
            }

            _formsAuthentication.SetAuthCookie(confirmationResult.Username, createPersistentCookie: false);
            return Redirect(HomePath);
        }
    }
}