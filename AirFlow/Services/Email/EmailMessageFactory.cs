using AirFlow.Models.Common;
using AirFlow.Services.Helpers;
using System;
using System.Net.Mail;
using System.Web;

namespace AirFlow.Services.Email
{
    internal static class EmailMessageFactory
    {
        public static MailMessage Construct(EmailMessageType type, EmailMessageOptions options)
        {
            string emailTemplate;

            switch (type)
            {
                case EmailMessageType.EmailConfirmation:
                    emailTemplate = GetEmailTemplate("Register", "confirmationEmailTemplate");
                    return new EmailConfirmationEmailMessage(emailTemplate, options as ConfirmationEmailMessageOptions);

                case EmailMessageType.LoginConfirmation:
                    emailTemplate = GetEmailTemplate("Login", "confirmationEmailTemplate");
                    return new LoginConfirmationEmailMessage(emailTemplate, options as ConfirmationEmailMessageOptions);

                case EmailMessageType.TemperatureChangeRequest:
                    return new TemperatureRequestEmailMessage(options as TemperatureRequestEmailMessageOptions);

                default:
                    throw new InvalidOperationException($"No email message defined for type {type}");
            }
        }

        private static string GetEmailTemplate(string contentName, string emailTemplatePropertyAlias)
        {
            string template = AirFlowHelper.Instance.GetSingleContentPropertyValue<string>(contentName, emailTemplatePropertyAlias, AirFlowConstants.RootContentLevel);
            return HttpUtility.HtmlDecode(template);
        }
    }
}