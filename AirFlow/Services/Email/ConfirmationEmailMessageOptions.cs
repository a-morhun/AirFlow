using System;

namespace AirFlow.Services.Email
{
    internal class ConfirmationEmailMessageOptions : EmailMessageOptions
    {
        public string Token { get; }

        public DateTimeOffset ExpirationDateTime { get; }

        public ConfirmationEmailMessageOptions(string sendTo, string token, DateTimeOffset expirationDateTime)
            : base(sendTo)
        {
            Token = token;
            ExpirationDateTime = expirationDateTime;
        }
    }
}