using System;
using System.Security.Cryptography;

namespace AirFlow.Services.Auth
{
    public class TokenGenerator : ITokenGenerator
    {
        private const int NumberOfBytes = 32;

        public string Generate()
        {
            var buffer = new byte[NumberOfBytes];
            using (var randomProvider = new RNGCryptoServiceProvider())
            {
                randomProvider.GetBytes(buffer);
            }

            return Convert.ToBase64String(buffer);
        }
    }
}