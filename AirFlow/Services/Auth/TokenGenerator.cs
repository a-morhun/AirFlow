using System;
using System.Security.Cryptography;

namespace AirFlow.Services.Auth
{
    internal class TokenGenerator : ITokenGenerator
    {
        private const int NumberOfBytes = 32;

        public string Generate()
        {
            var randomBytes = GenerateRandomBytes();
            var base64 = Convert.ToBase64String(randomBytes);
            return ReplaceToUrlSafe(base64);
        }

        private static string ReplaceToUrlSafe(string base64)
        {
            return base64.TrimEnd('=').Replace('+', '-').Replace('/', '_');
        }

        private static byte[] GenerateRandomBytes()
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