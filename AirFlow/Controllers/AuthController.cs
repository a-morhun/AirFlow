using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    // TODO: should be rewritten using API controller
    public class AuthController : SurfaceController
    {
        private readonly IAuthService _authService;
        private readonly IFormsAuthentication _formsAuthentication;
        private readonly IMembership _membership;

        /// <summary>
        /// TODO: remove when an issue with IOC configuration will be fixed
        /// </summary>
        public AuthController()
        {
            _formsAuthentication = new FormsAuthenticationWrapper();
            _membership = new MembershipWrapper();
            _authService = new AuthService();
        }

        public AuthController(
            IAuthService authService,
            IFormsAuthentication formsAuthentication,
            IMembership membership)
        {
            _authService = authService;
            _formsAuthentication = formsAuthentication;
            _membership = membership;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Login(UserLoginViewModel loginRequest)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }

            string username = _membership.GetUserNameByEmail(loginRequest.Email);

            if (!string.IsNullOrEmpty(username) && _membership.ValidateUser(username, loginRequest.Password))
            {
                _formsAuthentication.SetAuthCookie(username, createPersistentCookie: true);
                return Redirect("/");
            }

            return Content("Invalid credentials provided");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [MemberAuthorize]
        public ActionResult Logout()
        {
            _formsAuthentication.SignOut();
            return Redirect("/login");
        }

        [HttpGet]
        // TODO: Deal with routes
        [Route("/registration/confirm")]
        public ActionResult ConfirmEmail(string token)
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