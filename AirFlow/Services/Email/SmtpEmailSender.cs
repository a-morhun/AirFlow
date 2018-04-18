using System.Configuration;
using System.IO;
using System.Net.Configuration;
using System.Net.Mail;

namespace AirFlow.Services.Email
{
    public class SmtpEmailSender : IEmailSender
    {
        private readonly SmtpClient _client;
        private readonly SmtpSection _section;

        public SmtpEmailSender()
        {
            _client = new SmtpClient();
            _section = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
            InitSmtpEnvironment();
        }

        private void InitSmtpEnvironment()
        {
            if (_section.DeliveryMethod == SmtpDeliveryMethod.SpecifiedPickupDirectory)
            {
                Directory.CreateDirectory(_section.SpecifiedPickupDirectory.PickupDirectoryLocation);
            }
        }

        public void Send(MailMessage message)
        {
            _client.Send(message);
        }
    }
}