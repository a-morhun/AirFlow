using System.Web.Mvc;
using AirFlow.Models.Account;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using AirFlow.Services.Auth;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AccountController : SurfaceController
    {
        private readonly IAccountService _accountServicee;
        private readonly IFormsAuthentication _formsAuthentication;

        public AccountController(IAccountService accountService, IFormsAuthentication formsAuthentication)
        {
            _accountServicee = accountService;
            _formsAuthentication = formsAuthentication;
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

            Result result = _accountServicee.Register(new UserToRegister(registrationRequest));

            if (result.IsSuccess)
            {
                var registrationResult = result as RegistrationResult;

                if (registrationResult.ShouldAutoLogin)
                {
                    _formsAuthentication.SetAuthCookie(registrationRequest.Username, createPersistentCookie: false);
                    return Redirect("/");
                }

                return Redirect("/login");
            }

            return Content(result.ErrorMessage);
        }
    }
}