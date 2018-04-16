using System.Threading;
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
        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;
        private const string PartialErrorViewPath = "/Views/Partials/Auth/";

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
                return PartialView($"{PartialErrorViewPath}_LoginError.cshtml", "Please, verify input data");
            }

            LoginResult loginResult = _authService.Login(new UserToLogin(loginRequest));

            if (loginResult.IsSuccess)
            {
                _formsAuthentication.SetAuthCookie(loginResult.Username, createPersistentCookie: true);
                return JavaScript("window.location = '/'");
            }

            return PartialView($"{PartialErrorViewPath}_LoginError.cshtml", loginResult.ErrorCode.Value.ToString());
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
                return View("/Views/ConfirmEmailFailure.cshtml");
            }

            Result confirmationResult = _authService.ConfirmEmail(token);

            if (!confirmationResult.IsSuccess)
            {
                return View("/Views/ConfirmEmailFailure.cshtml");
            }

            return View("/Views/ConfirmEmailSuccess.cshtml");
        }
    }
}