using AirFlow.Data.Security;
using AirFlow.Data.Security.Account;
using AirFlow.Data.Security.Auth;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Containers;
using System;

namespace AirFlow.Services.Auth
{
    internal class AuthService : IAuthService
    {
        private readonly IMembership _membership;
        private readonly ISecurityRepository _securityRepository;
        private readonly IServiceContainer _serviceContainer;

        public AuthService(
            IMembership membership,
            ISecurityRepository securityRepository,
            IServiceContainer serviceContainer)
        {
            _membership = membership;
            _securityRepository = securityRepository;
            _serviceContainer = serviceContainer;
        }

        public LoginResult Login(UserToLogin user)
        {
            AdditionalLoginInfo additionalInfo = _securityRepository.GetAdditionalLoginInfo(user.Email);

            if (additionalInfo == null)
            {
                return new LoginResult(ErrorCodeType.MemberNotFound);
            }

            if (!_membership.ValidateUser(additionalInfo.Username, user.Password))
            {
                return new LoginResult(ErrorCodeType.MemberIsNotApprovedOrInvalidCredentials);
            }

            if (!_securityRepository.IsEmailConfirmed(user.Email))
            {
                return new LoginResult(ErrorCodeType.MemberHasNotConfirmedEmail);
            }

            var type = (LoginType)additionalInfo.LoginType;

            if (type == LoginType.TwoFactorViaEmail)
            {
                var provider = _serviceContainer.GetInstance<ITwoFactorLoginProvider>(new ConstructorParameter("userEmail", user.Email));
                provider.Process(additionalInfo.UserId);
            }

            return new LoginResult(additionalInfo.Username, type);
        }

        public Result ConfirmEmail(string token)
        {
            ConfirmationToken tokedDetails = _securityRepository.GetConfirmationTokenDetails(token);

            if (tokedDetails == null)
            {
                return new Result(ErrorCodeType.ConfirmationTokenInfoNotFound);
            }

            if (tokedDetails.AlreadyConfirmed)
            {
                return new Result(ErrorCodeType.MemberHasAlreadyConfirmedEmail);
            }

            if (tokedDetails.IsExpired)
            {
                return new Result(ErrorCodeType.ConfirmationTokenIsExpired);
            }

            try
            {
                _securityRepository.ConfirmEmail(tokedDetails.ForUserId);
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }

            return Result.Success;
        }

        public LoginResult ConfirmLogin(string token)
        {
            Token tokenDetails = _securityRepository.GetLoginTokenDetails(token);

            if (tokenDetails == null)
            {
                return new LoginResult(ErrorCodeType.LoginTokenInfoNotFound);
            }

            if (tokenDetails.IsExpired)
            {
                return new LoginResult(ErrorCodeType.LoginTokenIsExpired);
            }

            string username;
            try
            {
                username = _securityRepository.ConfirmLogin(tokenDetails.ForUserId);
            }
            catch (Exception e)
            {
                return new LoginResult(ErrorCodeType.UnknownError, e.Message);
            }

            return new LoginResult(username);
        }
    }
}