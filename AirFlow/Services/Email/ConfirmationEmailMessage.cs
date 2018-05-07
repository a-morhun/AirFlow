using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal  abstract class ConfirmationEmailMessage : MailMessage
    {
        protected ConfirmationEmailMessage(string subject, string actionName, string bodyTemplate, ConfirmationEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = subject;
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;

            var href = $"{AirFlowConfiguration.AirFlowUrl}/umbraco/Surface/AuthSurface/{actionName}?token={options.Token}";
            const string confirmationLinkName = "Confirmation";
            Body = string.Format(bodyTemplate, href, confirmationLinkName, options.ExpirationDateTime.ToUniversalTime());
        }
    }
}