using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Models.Account;
using AirFlow.ServiceContainers;
using Autofac;
using System;
using Umbraco.Core.Services;
using Umbraco.Core.Models;

namespace AirFlow.Services.Account
{
    public class AccountService : IAccountService
    {
        private readonly IMemberService _memberService;

        public AccountService(IMemberService memberService)
        {
            _memberService = memberService;
        }

        public Result Register(UserToRegister user)
        {
            if (_memberService.Exists(user.Username) || _memberService.GetByEmail(user.Email) != null)
            {
                return new Result(ErrorCodeType.MemberAlreadyExists, "Already exists");
            }

            try
            {
                IUserRegistration userRegistration = AirFlowServiceContainer.Container.ResolveKeyed<IUserRegistration>(user.Type);
                IMember registeredUser = userRegistration.Register(user);
                return new RegistrationResult(shouldAutoLogin: registeredUser.IsApproved);
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }
        }
    }
}