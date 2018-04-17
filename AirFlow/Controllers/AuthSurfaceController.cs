using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AuthSurfaceController : SurfaceController
    {
        private const string PartialViewLoginError = "/Views/Partials/Auth/_LoginError.cshtml";
        private const string ViewConfirmationSuccess = "/Views/ConfirmEmailSuccess.cshtml";
        private const string ViewConfirmationFailure = "/Views/ConfirmEmailFailure.cshtml";

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
                return PartialView(PartialViewLoginError, new ResultViewModel("Please, verify input data", isSuccess: false));
            }

            LoginResult loginResult = _authService.Login(new UserToLogin(loginRequest));

            if (loginResult.IsFailure)
            {
                return PartialView(PartialViewLoginError, new ResultViewModel(loginResult.ErrorCode.Value.ToString(), isSuccess: false));
            }

            _formsAuthentication.SetAuthCookie(loginResult.Username, createPersistentCookie: true);
            return JavaScript("window.location = '/'");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MemberAuthorize]
        public ActionResult Logout()
        {
            _formsAuthentication.SignOut();
            return Redirect("/");
        }

        [HttpGet]
        public ActionResult ConfirmEmail(string token)
        {
            if (string.IsNullOrEmpty(token))
            {
                return View(ViewConfirmationFailure);
            }

            Result confirmationResult = _authService.ConfirmEmail(token);

            if (confirmationResult.IsFailure)
            {
                return View(ViewConfirmationFailure);
            }

            return View(ViewConfirmationSuccess);
        }
    }
}