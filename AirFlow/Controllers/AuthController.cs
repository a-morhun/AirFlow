using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services;
using AirFlow.Services.Abstract;
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
            _authService = new AuthService(Services.MemberService, Services.MemberTypeService);
            _formsAuthentication = new FormsAuthenticationWrapper();
            _membership = new MembershipWrapper();
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

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Register(UserRegistrationViewModel registrationRequest)
        {
            if (!ModelState.IsValid)
            {
                return CurrentUmbracoPage();
            }

            Result result = _authService.Register(registrationRequest);

            if (result.IsSuccess)
            {
                var registrationResult = result as RegistrationResult;

                if (registrationResult.ShouldAutoLogin)
                {
                    SetAuthCookie(registrationRequest.Username);
                    return Redirect("/");
                }

                return Redirect("/login");
            }

            return Content(result.ErrorMessage);
        }

        private void SetAuthCookie(string username)
        {
            _formsAuthentication.SetAuthCookie(username, createPersistentCookie: false);
        }
    }
}