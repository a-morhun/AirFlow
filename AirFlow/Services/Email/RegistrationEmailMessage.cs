using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal class RegistrationEmailMessage : MailMessage
    {
        public RegistrationEmailMessage(string bodyTemplate, ConfirmationEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = "AirFlow registration";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;

            string href = string.Format("{0}/umbraco/Surface/AuthSurface/ConfirmEmail?token={1}", AirFlowConfiguration.AirFlowUrl, options.Token);
            const string confirmationLinkName = "Confirmation";
            Body = string.Format(bodyTemplate, href, confirmationLinkName, options.ExpirationDateTime.ToUniversalTime());
        }
    }
}