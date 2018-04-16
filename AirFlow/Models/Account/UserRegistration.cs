using System;
using System.Net.Mail;
using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public class UserRegistration : IUserRegistration
    {
        private const string DefaultMemberType = "Member";
        private const string RegularMemberGroup = "Regular";

        protected readonly IMemberService MemberService;
        protected readonly IMemberTypeService MemberTypeService;
        protected readonly IUserSecurityRepository Repository;
        private readonly ITokenGenerator _tokenGenerator;
        private readonly IEmailSender _emailSender;

        private readonly DateTime _expirationTokenDateTime = DateTime.UtcNow.AddDays(1);

        public UserRegistration(
            IMemberService memberService,
            IMemberTypeService memberTypeService,
            IUserSecurityRepository securityRepository,
            ITokenGenerator tokenGenerator,
            IEmailSender emailSender)
        {
            MemberService = memberService;
            MemberTypeService = memberTypeService;
            Repository = securityRepository;
            _tokenGenerator = tokenGenerator;
            _emailSender = emailSender;
        }

        public IMember Register(UserToRegister user)
        {
            IMember registeredUser = CreateMember(user);
            SaveRegistrationConfirmation(registeredUser.Id, out string token);
            SendConfirmationEmail(token, registeredUser.Email);

            return registeredUser;
        }

        private IMember CreateMember(UserToRegister user)
        {
            IMember registeredUser = MemberService.CreateMemberWithIdentity(user.Username, user.Email, user.Name, DetermineMemberType().Alias);
            registeredUser.IsApproved = user.Type == UserType.ValtechUk;
            MemberService.SavePassword(registeredUser, user.Password);
            MemberService.Save(registeredUser);
            MemberService.AssignRole(registeredUser.Id, RegularMemberGroup);

            return registeredUser;
        }

        private void SaveRegistrationConfirmation(int userId, out string token)
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

        private IMemberType DetermineMemberType()
        {
            return MemberTypeService.Get(DefaultMemberType);
        }
    }
}