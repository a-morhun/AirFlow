using System;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    public class LoginConfirmationEmailMessage : MailMessage
    {
        private const string UrlBase = "http://localhost:51356";

        private readonly string _bodyTemplate =
            "<p>Please, confirm you login using following link:</p>" +
            "<p style=\"text-align: center;\"><a href=\"{0}/umbraco/Surface/AuthSurface/ConfirmLogin?token={1}\">{2}</a></p>" +
            "<p><strong>Attention! The link will have been expired by {2}</strong></p>" +
            "<p>Do not respond to this email - it was auto-generated. If you have received it mistakely just ignore it. </p>";

        public LoginConfirmationEmailMessage(string mailSendTo, string token, DateTimeOffset expirationDateTime)
        {
            To.Add(mailSendTo);
            Subject = "AirFlow login confirmation";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;
            Body = string.Format(_bodyTemplate, UrlBase, token, "Confirmation", expirationDateTime.ToLocalTime());
        }
    }
}