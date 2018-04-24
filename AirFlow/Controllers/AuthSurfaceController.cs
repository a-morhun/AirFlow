using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System.Web.Mvc;
using Umbraco.Web;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AuthSurfaceController : SurfaceController
    {
        private const string PartialViewLoginMessage = "/Views/Partials/Auth/_LoginMessage.cshtml";
        private const string ViewEmailConfirmationSuccess = "/Views/ConfirmEmailSuccess.cshtml";
        private const string ViewEmailConfirmationFailure = "/Views/ConfirmEmailFailure.cshtml";
        private const string ViewLoginConfirmationFailure = "/Views/ConfirmLoginFailure.cshtml";
        private const string HomePath = "/";

        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;

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
                return JavaScript($"window.location = '{HomePath}'");
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
                CurrentPage.Site().Descendant("emailConfirmation");
                return RedirectToUmbracoPage(Umbraco.ContentAtXPath("//EmailConfirmationFailure"));
            }

            Result confirmationResult = _authService.ConfirmEmail(token);

            if (confirmationResult.IsFailure)
            {
                return RedirectToUmbracoPage(Umbraco.TypedContentSingleAtXPath("//EmailConfirmationFailure"));
            }

            return View(ViewEmailConfirmationSuccess);
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