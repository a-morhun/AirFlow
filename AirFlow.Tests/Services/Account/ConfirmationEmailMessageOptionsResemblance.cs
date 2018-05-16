using AirFlow.Services.Email;
using System;

namespace AirFlow.Tests.Services.Account
{
    internal class ConfirmationEmailMessageOptionsResemblance : ConfirmationEmailMessageOptions
    {
        public ConfirmationEmailMessageOptionsResemblance(string sendTo, string token, DateTimeOffset expirationDateTime)
            : base(sendTo, token, expirationDateTime)
        {
        }

        public override bool Equals(object obj)
        {
            var options = obj as ConfirmationEmailMessageOptions;

            if (options == null)
            {
                return base.Equals(obj);
            }

            return options.SendTo == SendTo &&
                   options.Token == Token;
        }

        public override int GetHashCode()
        {
            return 0;
        }
    }
}