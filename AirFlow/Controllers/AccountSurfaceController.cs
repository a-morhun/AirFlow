using AirFlow.Models.Account;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using AirFlow.Utilities;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class AccountSurfaceController : SurfaceController
    {
        private const string PartialMessageViewPath = "/Views/Partials/Account/_RegistrationResult.cshtml";

        private readonly IAccountService _accountService;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AccountSurfaceController));

        public AccountSurfaceController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Register(UserRegistrationViewModel registrationRequest)
        {
            _logger.Debug($"registrationRequest: {registrationRequest}");
            if (!ModelState.IsValid)
            {
                return PartialView(PartialMessageViewPath, new ResultViewModel("Please, verify input data", isSuccess: false));
            }

            Result result = _accountService.Register(new UserToRegister(registrationRequest));
            _logger.Debug(result.ToString());

            if (result.IsFailure)
            {
                return PartialView(PartialMessageViewPath, new ResultViewModel(result.ErrorMessage, isSuccess: false));
            }

            return PartialView(PartialMessageViewPath, new ResultViewModel("Confirmation message was sent to your email. Please, complete your registration.", isSuccess: true));
        }
    }
}