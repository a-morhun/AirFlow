using AirFlow.Models.Common;
using AirFlow.Models.Account;
using AirFlow.Utilities;
using System;
using Umbraco.Core.Services;

namespace AirFlow.Services.Account
{
    internal class AccountService : IAccountService
    {
        private readonly IMemberService _memberService;
        private readonly IUserRegistration _userRegistration;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AccountService));

        public AccountService(IMemberService memberService, IUserRegistration userRegistration)
        {
            _memberService = memberService;
            _userRegistration = userRegistration;
        }

        public Result Register(UserToRegister user)
        {
            if (!CanRegister(user))
            {
                _logger.Info($"Cannot register user '{user.Email}' - Already exists");
                return new Result(ErrorCodeType.MemberAlreadyExists, "Already exists");
            }

            try
            {
                _userRegistration.Register(user);
                _logger.Debug($"User '{user.Email}' was registred");
                return Result.Success;
            }
            catch (Exception e)
            {
                _logger.Error($"Failed to register a new user '{user.Email}'", e);
                return new Result(ErrorCodeType.UnknownError);
            }
        }

        private bool CanRegister(UserToRegister user)
        {
            return _memberService.GetByEmail(user.Email) == null;
        }
    }
}