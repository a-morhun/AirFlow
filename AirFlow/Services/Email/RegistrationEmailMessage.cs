using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal class RegistrationEmailMessage : MailMessage
    {
        private const string BodyTemplate =
            "<h4 style=\"text-align: center;\">Thank you for your registrastion in <strong>AirFlow</strong>!</h4>" +
            "<p>Please, confirm you email address using following link:</p>" +
            "<p style=\"text-align: center;\"><a href=\"{0}/umbraco/Surface/AuthSurface/ConfirmEmail?token={1}\">{2}</a></p>" +
            "<p><strong>Attention! The link will have been expired by {3}</strong></p>" +
            "<p>Do not respond to this email - it was auto-generated. If you have received it mistakely just ignore it. </p>";

        public RegistrationEmailMessage(ConfirmationEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = "AirFlow registration";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;
            Body = string.Format(BodyTemplate, AirFlowConfiguration.AirFlowUrl, options.Token, "Confirmation", options.ExpirationDateTime.ToLocalTime());
        }
    }
}