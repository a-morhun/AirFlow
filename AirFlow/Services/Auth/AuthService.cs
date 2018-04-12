using System;
using AirFlow.Data;
using AirFlow.Data.Abstract;
using AirFlow.Models.Common;

namespace AirFlow.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserSecurityRepository _userSecurityRepository;

        public AuthService()
        {
            _userSecurityRepository = new UserSecurityRepository();
        }

        public AuthService(IUserSecurityRepository userSecurityRepository)
        {
            _userSecurityRepository = userSecurityRepository;
        }

        public Result ConfirmEmail(string token)
        {
            (int UserId, DateTime ExpirationDate)? confirmationInfo = _userSecurityRepository.GetByConfirmationToken(token);

            if (confirmationInfo == null)
            {
                return new Result(ErrorCodeType.MemberNotFound);
            }

            if (confirmationInfo.Value.ExpirationDate >= DateTime.UtcNow)
            {
                return new Result(ErrorCodeType.ConfirmationTokenInOutDated);
            }

            //_repository.ConfirmEmail(confirmationInfo.Value.UserId);
            return new Result();
        }
    }
}