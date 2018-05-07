using AirFlow.Data.Security.Auth;
using AirFlow.Utilities;
using System;

namespace AirFlow.Services.Auth
{
    internal abstract class TwoFactorLoginProvider : ITwoFactorLoginProvider
    {
        private readonly ILoginRepository _loginRepository;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(TwoFactorLoginProvider));

        protected DateTime ExpirationDateTime = DateTime.UtcNow.AddMinutes(5);

        protected TwoFactorLoginProvider(ILoginRepository loginRepository)
        {
            _loginRepository = loginRepository;
        }

        protected abstract string GenerateToken();
        protected abstract void SendConfirmation(string token);

        public void Process(int userId)
        {
            string token = GenerateToken();
            SaveLoginToken(userId, token);
            SendConfirmation(token);
        }

        private void SaveLoginToken(int userId, string token)
        {
            var twoFactorLoginDto = new TwoFactorLoginDto
            {
                Token = token,
                ExpirationDate = ExpirationDateTime,
                UserId = userId,
            };

            _logger.Debug($"SaveLoginTokenInfo: {twoFactorLoginDto}");
            _loginRepository.SaveLoginToken(twoFactorLoginDto);
        }
    }
}