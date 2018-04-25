using AirFlow.Data.Security.Account;
using AirFlow.Data.Security.Auth;

namespace AirFlow.Data.Security
{
    public class SecurityRepository : ISecurityRepository
    {
        private readonly IAccountRepository _accountRepository;
        private readonly ILoginRepository _loginRepository;

        public SecurityRepository(IAccountRepository accountRepository, ILoginRepository loginRepository)
        {
            _accountRepository = accountRepository;
            _loginRepository = loginRepository;
        }

        public void Save(UserAccountDto user)
        {
            _accountRepository.Save(user);
        }

        public ConfirmationToken GetConfirmationTokenDetails(string confirmationToken)
        {
            return _accountRepository.GetConfirmationTokenDetails(confirmationToken);
        }

        public void ConfirmEmail(int userId)
        {
            _accountRepository.ConfirmEmail(userId);
        }

        public bool IsEmailConfirmed(string email)
        {
            return _accountRepository.IsEmailConfirmed(email);
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

        public AdditionalLoginInfo GetAdditionalLoginInfo(string email)
        {
            return _loginRepository.GetAdditionalLoginInfo(email);
        }
    }
}