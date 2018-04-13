using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    [RoutePrefix("auth")]
    public class AuthController : SurfaceController
    {
        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;

        public AuthController(
            IAuthService authService,
            IFormsAuthentication formsAuthentication)
        {
            _authService = authService;
            _formsAuthentication = formsAuthentication;
        }

        [HttpPost]
        [Route("login")]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Login(UserLoginViewModel loginRequest)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }

            LoginResult loginResult = _authService.Login(new UserToLogin(loginRequest));

            if (loginResult.IsSuccess)
            {
                _formsAuthentication.SetAuthCookie(loginResult.Username, createPersistentCookie: true);
                return Redirect("/");
            }

            return Content(loginResult.ErrorCode.Value.ToString());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MemberAuthorize]
        public ActionResult Logout()
        {
            _formsAuthentication.SignOut();
            return Redirect("/auth/login");
        }

        [HttpGet]
        [Route("registration/confirm")]
        public ActionResult ConfirmEmail(string token = null)
        {
            Result confirmationResult = _authService.ConfirmEmail(token);

            if (confirmationResult.IsSuccess)
            {
                return Content("Email confirmed");
            }

            return Content("Error:" + confirmationResult.ErrorMessage);
        }
    }
}