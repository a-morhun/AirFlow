using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using NSubstitute;
using NUnit.Framework;
using System;

namespace AirFlow.Tests.Services.Auth
{
    [TestFixture]
    public class EmailTypeLoginProcessorTests
    {
        private const string UserEmail = "user@com";
        private const string Token = "token";
        private const int UserId = 1;
        
        private ITokenGenerator _tokenGenerator;
        private IEmailSender _emailSender;
        private ILoginRepository _loginRepository;
        private ITwoFactorLoginProvider _loginProcessor;

        [SetUp]
        public void SetUp()
        {
            _tokenGenerator = Substitute.For<ITokenGenerator>();
            _emailSender = Substitute.For<IEmailSender>();
            _loginRepository = Substitute.For<ILoginRepository>();

            _loginProcessor = new EmailTypeLoginProvider(UserEmail, _loginRepository, _tokenGenerator, _emailSender);
        }

        [Test]
        public void Process_TokenGenerated_SavedLoginToken_EmailSent_Success()
        {
            // Arrange
            _tokenGenerator.Generate().Returns(Token);

            // Act
            _loginProcessor.Process(UserId);

            // Assert
            AssertIfTokenGenerated();
            AssertIfLoginTokenSaved();
            AssertIfConfirmationEmailWasSent();
        }

        private void AssertIfTokenGenerated()
        {
            _tokenGenerator.Received(1).Generate();
        }

        private void AssertIfLoginTokenSaved()
        {
            _loginRepository.Received(1).SaveLoginToken(Arg.Is< TwoFactorLoginDto>(t => 
                t.Token == Token && 
                t.UserId == UserId && 
                t.ExpirationDate > DateTime.UtcNow));
        }

        private void AssertIfConfirmationEmailWasSent()
        {
            _emailSender.Received(1).Send(Arg.Is<LoginConfirmationEmailMessage>(r =>
                r != null &&
                r.IsBodyHtml &&
                !string.IsNullOrEmpty(r.Subject) &&
                !string.IsNullOrEmpty(r.Body)));
        }
    }
}