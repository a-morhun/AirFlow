using System;
using System.Net.Mail;

namespace AirFlow.Services.Email
{
    internal static class EmailMessageFactory
    {
        public static MailMessage Construct(EmailMessageType type, EmailMessageOptions options)
        {
            switch (type)
            {
                case EmailMessageType.EmailConfirmation:
                    return new RegistrationEmailMessage(options as ConfirmationEmailMessageOptions);

                case EmailMessageType.LoginConfirmation:
                    return new LoginConfirmationEmailMessage(options as ConfirmationEmailMessageOptions);

                case EmailMessageType.TemperatureChangeRequest:
                    return new TemperatureRequestEmailMessage(options as TemperatureRequestEmailMessageOptions);

                default:
                    throw new InvalidOperationException($"No email message defined for type {type}");
            }
        }
    }
}