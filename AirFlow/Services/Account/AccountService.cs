using AirFlow.Models.Common;
using AirFlow.Models.Account;
using System;
using Umbraco.Core.Services;

namespace AirFlow.Services.Account
{
    internal class AccountService : IAccountService
    {
        private readonly IMemberService _memberService;
        private readonly IUserRegistration _userRegistration;

        public AccountService(IMemberService memberService, IUserRegistration userRegistration)
        {
            _memberService = memberService;
            _userRegistration = userRegistration;
        }

        public Result Register(UserToRegister user)
        {
            if (!CanRegister(user))
            {
                return new Result(ErrorCodeType.MemberAlreadyExists, "Already exists");
            }

            try
            {
                _userRegistration.Register(user);
                return Result.Success;
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }
        }

        private bool CanRegister(UserToRegister user)
        {
            return _memberService.GetByEmail(user.Email) == null;
        }
    }
}