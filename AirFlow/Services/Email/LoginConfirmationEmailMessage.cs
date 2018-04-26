using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal class LoginConfirmationEmailMessage : MailMessage
    {
        private const string BodyTemplate =
            "<p>Please, confirm you login using following link:</p>" +
            "<p style=\"text-align: center;\"><a href=\"{0}/umbraco/Surface/AuthSurface/ConfirmLogin?token={1}\">{2}</a></p>" +
            "<p><strong>Attention! The link will have been expired by {3}</strong></p>" +
            "<p>Do not respond to this email - it was auto-generated. If you have received it mistakely just ignore it. </p>";

        public LoginConfirmationEmailMessage(string emailTemplate, ConfirmationEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = "AirFlow login confirmation";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;

            string href = string.Format("{0}/umbraco/Surface/AuthSurface/ConfirmLogin?token={1}", AirFlowConfiguration.AirFlowUrl, options.Token);
            const string confirmationLinkName = "Confirmation";
            Body = string.Format(emailTemplate, href, confirmationLinkName, options.ExpirationDateTime.ToUniversalTime());
        }
    }
}