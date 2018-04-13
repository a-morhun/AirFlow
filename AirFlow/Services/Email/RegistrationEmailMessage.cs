using System;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    public class RegistrationEmailMessage : MailMessage
    {
        private string bodyTemplate =
            "<h4 style=\"text-align: center;\">Thank you for your registrastion in <strong>AirFlow</strong>!</h4>" +
            "<p>Please, confirm you email address using following link:</p>" +
            "<p style=\"text-align: center;\"><a href=\"http://localhost:51356/auth/registration/confirm?token={0}\">{1}</a></p>" +
            "<p><strong>Attention! The link will have been expired by {2}</strong></p>" +
            "<p>Do not respond to this email - it was auto-generated. If you have received it mistakely just ignore it. </p>";

        public RegistrationEmailMessage(string mailSendTo, string token, DateTimeOffset expirationDateTime)
        {
            To.Add(mailSendTo);
            Subject = "AirFlow registration";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;
            Body = string.Format(bodyTemplate, token, "Confirmation", expirationDateTime.ToLocalTime());
        }
    }
}