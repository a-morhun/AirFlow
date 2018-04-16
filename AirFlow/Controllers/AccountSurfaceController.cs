using System.Web.Mvc;
using AirFlow.Models.Account;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using AirFlow.Services.Auth;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AccountSurfaceController : SurfaceController
    {
        private readonly IAccountService _accountServicee;
        private readonly IFormsAuthentication _formsAuthentication;
        private const string PartialMessageViewPath = "/Views/Partials/Account/_RegistrationResult.cshtml";


        public AccountSurfaceController(IAccountService accountService, IFormsAuthentication formsAuthentication)
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
                return PartialView(PartialMessageViewPath, new ResultViewModel("Please, verify input data", isSuccess: false));
            }

            Result result = _accountServicee.Register(new UserToRegister(registrationRequest));

            if (!result.IsSuccess)
            {
                return PartialView(PartialMessageViewPath, new ResultViewModel(result.ErrorMessage, isSuccess: false));
            }

            return PartialView(PartialMessageViewPath, new ResultViewModel("Confirmation message was sent to your email. Please, complete your registration.", isSuccess: true));
        }
    }
}