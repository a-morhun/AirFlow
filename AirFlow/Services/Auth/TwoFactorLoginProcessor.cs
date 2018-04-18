using System;
using AirFlow.Data;
using AirFlow.Data.Models;

namespace AirFlow.Services.Auth
{
    public abstract class TwoFactorLoginProcessor : ITwoFactorLoginProcessor
    {
        private readonly ILoginRepository _loginRepository;

        protected DateTime ExpirationDateTime = DateTime.UtcNow.AddMinutes(5);

        protected TwoFactorLoginProcessor(ILoginRepository loginRepository)
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

            _loginRepository.SaveLoginToken(twoFactorLoginDto);
        }
    }
}