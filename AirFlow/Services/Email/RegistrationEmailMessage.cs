using System;
using System.Net.Mail;
using System.Text;
using AirFlow.Models.Common;

namespace AirFlow.Services.Email
{
    public class RegistrationEmailMessage : MailMessage
    {
        private readonly string _bodyTemplate =
            "<h4 style=\"text-align: center;\">Thank you for your registrastion in <strong>AirFlow</strong>!</h4>" +
            "<p>Please, confirm you email address using following link:</p>" +
            "<p style=\"text-align: center;\"><a href=\"{0}/umbraco/Surface/AuthSurface/ConfirmEmail?token={1}\">{2}</a></p>" +
            "<p><strong>Attention! The link will have been expired by {2}</strong></p>" +
            "<p>Do not respond to this email - it was auto-generated. If you have received it mistakely just ignore it. </p>";

        public RegistrationEmailMessage(string mailSendTo, string token, DateTimeOffset expirationDateTime)
        {
            To.Add(mailSendTo);
            Subject = "AirFlow registration";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;
            Body = string.Format(_bodyTemplate, AirFlowConfiguration.AirFlowUrl, token, "Confirmation", expirationDateTime.ToLocalTime());
        }
    }
}