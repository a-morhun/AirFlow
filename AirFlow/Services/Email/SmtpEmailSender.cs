using System.Net.Mail;

namespace AirFlow.Services.Email
{
    public class SmtpEmailSender : IEmailSender
    {
        private readonly SmtpClient _client = new SmtpClient();

        public void Send(MailMessage message)
        {
            _client.Send(message);
        }
    }
}