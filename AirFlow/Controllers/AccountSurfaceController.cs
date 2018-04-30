using AirFlow.Models.Account;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using System.Web.Mvc;
using AirFlow.Utilities;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AccountSurfaceController : SurfaceController
    {
        private const string PartialMessageViewPath = "/Views/Partials/Account/_RegistrationResult.cshtml";

        private readonly IAccountService _accountService;
        private static readonly IAirFlowLogger Logger = new AirFlowLogger(typeof(AccountSurfaceController));

        public AccountSurfaceController(IAccountService accountService)
        {
            _accountService = accountService;
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

            Result result = _accountService.Register(new UserToRegister(registrationRequest));

            if (result.IsFailure)
            {
                return PartialView(PartialMessageViewPath, new ResultViewModel(result.ErrorMessage, isSuccess: false));
            }

            return PartialView(PartialMessageViewPath, new ResultViewModel("Confirmation message was sent to your email. Please, complete your registration.", isSuccess: true));
        }
    }
}