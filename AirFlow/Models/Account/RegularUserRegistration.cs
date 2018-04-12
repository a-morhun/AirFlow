using System;
using System.Net.Mail;
using AirFlow.Data.Abstract;
using AirFlow.Data.Models;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public class RegularUserRegistration : UserRegistration
    {
        private readonly ITokenGenerator _tokenGenerator;
        private readonly IEmailSender _emailSender;

        private readonly DateTime _expirationTokenDateTime = DateTime.UtcNow.AddDays(1);

        public RegularUserRegistration(
            IMemberService memberService,
            IMemberTypeService memberTypeService,
            IUserSecurityRepository securityRepository,
            ITokenGenerator tokenGenerator,
            IEmailSender emailSender) : base(memberService, memberTypeService, securityRepository)
        {
            _tokenGenerator = tokenGenerator;
            _emailSender = emailSender;
        }

        public override IMember Register(UserToRegister user)
        {
            IMember registeredUser = CreateMember(user);

            SaveSecurityInfo(registeredUser.Id, out string token);
            SendConfirmationEmail(token, registeredUser.Email);

            return registeredUser;
        }

        protected override void SaveSecurityInfo(int userId, out string token)
        {
            token = _tokenGenerator.Generate();

            var airflowMember = new AirFlowUserSecurity()
            {
                ConfirmationToken = token,
                ConfirmationExpirationDate = _expirationTokenDateTime,
                UserId = userId,
            };

            Repository.Save(airflowMember);
        }

        private void SendConfirmationEmail(string token, string userEmail)
        {
            MailMessage message = new RegistrationEmailMessage(userEmail, token, _expirationTokenDateTime);
            _emailSender.Send(message);
        }

        protected override void SetMemberApproval(IMember member)
        {
            member.IsApproved = false;
        }
    }
}