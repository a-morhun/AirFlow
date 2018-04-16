using System;
using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;

namespace AirFlow.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserSecurityRepository _userSecurityRepository;
        private readonly IMembership _membership;

        public AuthService(IMembership membership, IUserSecurityRepository userSecurityRepository)
        {
            _membership = membership;
            _userSecurityRepository = userSecurityRepository;
        }

        public LoginResult Login(UserToLogin user)
        {
            string username = _membership.GetUserNameByEmail(user.Email);

            if (string.IsNullOrEmpty(username))
            {
                return new LoginResult(ErrorCodeType.MemberNotFound);
            }

            if (!_userSecurityRepository.IsEmailConfirmed(user.Email))
            {
                return new LoginResult(ErrorCodeType.MemberHasNotConfirmedEmail);
            }

            if (!_membership.ValidateUser(username, user.Password))
            {
                return new LoginResult(ErrorCodeType.MemberProvidedInvalidLoginCredentials);
            }

            return new LoginResult(username);
        }

        public Result ConfirmEmail(string token)
        {
            ConfirmationToken confirmationInfo = _userSecurityRepository.GetByConfirmationToken(token);

            if (confirmationInfo == null)
            {
                return new Result(ErrorCodeType.MemberNotFound);
            }

            if (confirmationInfo.AlreadyConfirmed)
            {
                return new Result(ErrorCodeType.MemberHasAlreadyConfirmedEmail);
            }

            if (DateTime.UtcNow >= confirmationInfo.ExpirationDate)
            {
                return new Result(ErrorCodeType.ConfirmationTokenInOutDated);
            }

            try
            {
                _userSecurityRepository.ConfirmEmail(confirmationInfo.UserId);
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }

            return new Result();
        }
    }
}