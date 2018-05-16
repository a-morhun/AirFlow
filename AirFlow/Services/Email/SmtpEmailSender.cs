using AirFlow.Utilities;
using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Configuration;
using System.Net.Mail;

namespace AirFlow.Services.Email
{
    public class SmtpEmailSender : IEmailSender
    {
        private readonly SmtpClient _client;
        private readonly SmtpSection _section;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(SmtpEmailSender));

        public SmtpEmailSender()
        {
            _logger.Debug($"Init sender client");
            _client = new SmtpClient();
            _section = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");
           
            InitSmtpEnvironment();
            SetClientCredentials();
        }

        private void InitSmtpEnvironment()
        {
            _logger.Debug($"Initialized with ${_section.DeliveryMethod} delivery method");
            if (_section.DeliveryMethod == SmtpDeliveryMethod.SpecifiedPickupDirectory)
            {
                Directory.CreateDirectory(_section.SpecifiedPickupDirectory.PickupDirectoryLocation);
            }
        }

        private void SetClientCredentials()
        {
            if (_section.DeliveryMethod == SmtpDeliveryMethod.Network)
            {
                string username = ConfigurationManager.AppSettings["SendGridUserName"];
                string password = ConfigurationManager.AppSettings["SendGridPassword"];

                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    _logger.Error($"Credentials are missing for the client.");
                    throw new InvalidOperationException("Credentials are missing for the client.");
                }

                _client.Credentials = new NetworkCredential(username, password);
                _logger.Debug("Credentials for the client are read and applied");
            }
        }

        public void Send(EmailMessageType type, EmailMessageOptions options)
        {
            MailMessage message = EmailMessageFactory.Construct(type, options);
            _logger.Debug($"Message of type {options.GetType()} was constructed");

            try
            {
                _logger.Debug($"Message of type {options.GetType()} was sent");
                _client.Send(message);
            }
            catch (Exception e)
            {
                throw new EmailSenderException($"Failed to send email from {message.From} to {message.To.FirstOrDefault()} with options {options}", e);
            }
        }
    }
}