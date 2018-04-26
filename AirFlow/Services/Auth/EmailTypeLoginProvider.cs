using AirFlow.Data.Security.Auth;
using AirFlow.Services.Email;
using System.Net.Mail;

namespace AirFlow.Services.Auth
{
    internal class EmailTypeLoginProvider : TwoFactorLoginProvider
    {
        private readonly ITokenGenerator _tokenGenerator;
        private readonly IEmailSender _emailSender;

        private readonly string _userEmail;

        public EmailTypeLoginProvider(
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
            _emailSender.Send(EmailMessageType.LoginConfirmation, new ConfirmationEmailMessageOptions(_userEmail, token, ExpirationDateTime));
        }
    }
}