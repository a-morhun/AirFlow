using AirFlow.Utilities;
using System;
using System.Security.Cryptography;

namespace AirFlow.Services.Auth
{
    internal class TokenGenerator : ITokenGenerator
    {
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(TokenGenerator));
        private const int NumberOfBytes = 32;

        public string Generate()
        {
            _logger.Debug($"Generating token using {NumberOfBytes} bytes");
            var randomBytes = GenerateRandomBytes();
            var base64 = Convert.ToBase64String(randomBytes);
            string token = ReplaceToUrlSafe(base64);
            _logger.Debug($"Generated token: {token}");

            return token;
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