using System;
using System.Net.Mail;
using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Models.Account;
using AirFlow.Models.Auth;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Services.Account
{
    public class UserRegistration : IUserRegistration
    {
        private const string DefaultMemberType = "Member";
        private const string RegularMemberGroup = "Regular";

        private readonly IMemberService _memberService;
        private readonly IMemberTypeService _memberTypeService;
        private readonly IUserSecurityRepository _repository;
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
            _memberService = memberService;
            _memberTypeService = memberTypeService;
            _repository = securityRepository;
            _tokenGenerator = tokenGenerator;
            _emailSender = emailSender;
        }

        public void Register(UserToRegister user)
        {
            IMember registeredUser = CreateMember(user);
            SaveRegistrationConfirmation(registeredUser.Id, user.LoginType, out string token);
            SendConfirmationEmail(token, registeredUser.Email);
        }

        private IMember CreateMember(UserToRegister user)
        {
            IMember registeredUser = _memberService.CreateMemberWithIdentity(user.Username, user.Email, user.Name, DetermineMemberTypeAlias());
            registeredUser.IsApproved = user.Type == UserType.ValtechUk;
            _memberService.SavePassword(registeredUser, user.Password);
            _memberService.Save(registeredUser);
            _memberService.AssignRole(registeredUser.Id, RegularMemberGroup);

            return registeredUser;
        }

        private string DetermineMemberTypeAlias()
        {
            return _memberTypeService.Get(DefaultMemberType).Alias;
        }

        private void SaveRegistrationConfirmation(int userId, LoginType type, out string token)
        {
            token = _tokenGenerator.Generate();

            var registration = new UserRegistrationDto
            {
                ConfirmationToken = token,
                ConfirmationExpirationDate = _expirationTokenDateTime,
                UserId = userId,
                LoginType = (byte)type
            };

            _repository.Save(registration);
        }

        private void SendConfirmationEmail(string token, string userEmail)
        {
            MailMessage message = ConfirmationEmailMessageFactory.ConstructConfirmationMessage(
                EmailMessageType.EmailConfirmation, userEmail, token, _expirationTokenDateTime);

            _emailSender.Send(message);
        }
    }
}