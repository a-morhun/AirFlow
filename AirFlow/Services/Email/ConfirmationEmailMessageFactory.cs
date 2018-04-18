using System;
using System.Net.Mail;

namespace AirFlow.Services.Email
{
    public static class ConfirmationEmailMessageFactory
    {
        public static MailMessage ConstructConfirmationMessage(EmailMessageType type, string mailSendTo, string token, DateTimeOffset expirationDateTime)
        {
            switch (type)
            {
                case EmailMessageType.EmailConfirmation:
                    return new RegistrationEmailMessage(mailSendTo, token, expirationDateTime);

                case EmailMessageType.LoginConfirmation:
                    return new LoginConfirmationEmailMessage(mailSendTo, token, expirationDateTime);

                default:
                    throw new InvalidOperationException($"No email message defined for type {type}");
            }
        }
    }
}