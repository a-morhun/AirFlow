using System;
using System.Security.Cryptography;

namespace AirFlow.Services.Auth
{
    internal class TokenGenerator : ITokenGenerator
    {
        private const int NumberOfBytes = 32;

        public string Generate()
        {
            byte[] randomBytes = GenerateRandomBytes();
            string base64 = Convert.ToBase64String(randomBytes);
            return ReplaceToUrlSafe(base64);
        }

        private string ReplaceToUrlSafe(string base64)
        {
            return base64.TrimEnd(new[] { '=' }).Replace('+', '-').Replace('/', '_');
        }

        private byte[] GenerateRandomBytes()
        {
            var buffer = new byte[NumberOfBytes];

            using (var randomProvider = new RNGCryptoServiceProvider())
            {
                randomProvider.GetBytes(buffer);
            }

            return buffer;
        }
    }
}