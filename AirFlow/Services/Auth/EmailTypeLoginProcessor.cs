using AirFlow.Data;
using AirFlow.Services.Email;
using System.Net.Mail;

namespace AirFlow.Services.Auth
{
    public class EmailTypeLoginProcessor : TwoFactorLoginProcessor
    {
        private readonly ITokenGenerator _tokenGenerator;
        private readonly IEmailSender _emailSender;

        private readonly string _userEmail;

        public EmailTypeLoginProcessor(
            string userEmail,
            ILoginRepository loginRepository,
            ITokenGenerator tokenGenerator,
            IEmailSender emailSender) : base(loginRepository)
        {
            _tokenGenerator = tokenGenerator;
            _emailSender = emailSender;

            _userEmail = userEmail;
        }

        protected override string GenerateToken()
        {
            return _tokenGenerator.Generate();
        }

        protected override void SendConfirmation(string token)
        {
            MailMessage message = ConfirmationEmailMessageFactory.ConstructConfirmationMessage(
                EmailMessageType.LoginConfirmation, _userEmail, token, ExpirationDateTime);

            _emailSender.Send(message);
        }
    }
}