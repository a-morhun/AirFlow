using AirFlow.Data.Security;
using AirFlow.Data.Security.Account;
using AirFlow.Data.Security.Auth;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Containers;
using AirFlow.Utilities;
using System;

namespace AirFlow.Services.Auth
{
    internal class AuthService : IAuthService
    {
        private readonly IMembership _membership;
        private readonly ISecurityRepository _securityRepository;
        private readonly IServiceContainer _serviceContainer;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AuthService));

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
            _logger.Info($"Attempt to login for '{user.Email}'");
            AdditionalLoginInfo additionalInfo = _securityRepository.GetAdditionalLoginInfo(user.Email);

            if (additionalInfo == null)
            {
                _logger.Info($"User was not found: '{user.Email}'");
                return new LoginResult(ErrorCodeType.MemberNotFound);
            }

            if (!_membership.ValidateUser(additionalInfo.Username, user.Password))
            {
                _logger.Info($"User was not approved or password is not correct: '{user.Email}'");
                return new LoginResult(ErrorCodeType.MemberIsNotApprovedOrInvalidCredentials);
            }

            if (!_securityRepository.IsEmailConfirmed(user.Email))
            {
                _logger.Info($"User has not confirmed an email: '{user.Email}'");
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
                _logger.Info($"Token not found '{token}'");
                return new Result(ErrorCodeType.ConfirmationTokenInfoNotFound);
            }

            if (tokedDetails.AlreadyConfirmed)
            {
                _logger.Info($"Email was already confirmed '{tokedDetails}'");
                return new Result(ErrorCodeType.MemberHasAlreadyConfirmedEmail);
            }

            if (tokedDetails.IsExpired)
            {
                _logger.Info($"Token is expired '{tokedDetails}'");
                return new Result(ErrorCodeType.ConfirmationTokenIsExpired);
            }

            try
            {
                _securityRepository.ConfirmEmail(tokedDetails.ForUserId);
                _logger.Debug($"Email confirmed for userId: '{tokedDetails.ForUserId}'");
            }
            catch (Exception e)
            {
                _logger.Error($"Failed to confirm email '{token}'", e);
                return new Result(ErrorCodeType.UnknownError);
            }

            return Result.Success;
        }

        public LoginResult ConfirmLogin(string token)
        {
            Token tokenDetails = _securityRepository.GetLoginTokenDetails(token);

            if (tokenDetails == null)
            {
                _logger.Info($"Token not found '{token}'");
                return new LoginResult(ErrorCodeType.LoginTokenInfoNotFound);
            }

            if (tokenDetails.IsExpired)
            {
                _logger.Info($"Token is expired '{tokenDetails}'");
                return new LoginResult(ErrorCodeType.LoginTokenIsExpired);
            }

            string username;
            try
            {
                username = _securityRepository.ConfirmLogin(tokenDetails.ForUserId);
                _logger.Debug($"Login confirmed for user: '{username}'");
            }
            catch (Exception e)
            {
                _logger.Error($"Failed to confirm login '{tokenDetails}'", e);
                return new LoginResult(ErrorCodeType.UnknownError, e.Message);
            }

            return new LoginResult(username);
        }
    }
}