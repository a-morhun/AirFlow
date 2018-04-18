using AirFlow.Data.Models;

namespace AirFlow.Data
{
    public class AuthRepository : IAuthRepository
    {
        private readonly IUserSecurityRepository _userSecurityRepository;
        private readonly ILoginRepository _loginRepository;

        public AuthRepository(IUserSecurityRepository userSecurityRepository, ILoginRepository loginRepository)
        {
            _userSecurityRepository = userSecurityRepository;
            _loginRepository = loginRepository;
        }

        public void Save(UserRegistrationDto dto)
        {
            _userSecurityRepository.Save(dto);
        }

        public ConfirmationToken GetConfirmationTokenDetails(string confirmationToken)
        {
            return _userSecurityRepository.GetConfirmationTokenDetails(confirmationToken);
        }

        public void ConfirmEmail(int userId)
        {
            _userSecurityRepository.ConfirmEmail(userId);
        }

        public bool IsEmailConfirmed(string email)
        {
            return _userSecurityRepository.IsEmailConfirmed(email);
        }

        public void SaveLoginToken(TwoFactorLoginDto dto)
        {
            _loginRepository.SaveLoginToken(dto);
        }

        public Token GetLoginTokenDetails(string token)
        {
            return _loginRepository.GetLoginTokenDetails(token);
        }

        public string ConfirmLogin(int userId)
        {
            return _loginRepository.ConfirmLogin(userId);
        }
    }
}