using AirFlow.Data.Security.Account;
using AirFlow.Models.Account;
using AirFlow.Services.Account;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using NSubstitute;
using NUnit.Framework;
using System;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Tests.Services.Account
{
    [TestFixture]
    public class UserRegistrationTests
    {
        private IMemberService _memberService;
        private IMemberTypeService _memberTypeService;
        private IAccountRepository _accountRepository;
        private ITokenGenerator _tokenGenerator;
        private IEmailSender _emailSender;
        private IUserRegistration _userRegistration;

        [SetUp]
        public void SetUp()
        {
            _memberService = Substitute.For<IMemberService>();
            _memberTypeService = Substitute.For<IMemberTypeService>();
            _accountRepository = Substitute.For<IAccountRepository>();
            _tokenGenerator = Substitute.For<ITokenGenerator>();
            _emailSender = Substitute.For<IEmailSender>();

            _userRegistration = new UserRegistration(
                _memberService,
                _memberTypeService,
                _accountRepository,
                _tokenGenerator,
                _emailSender);
        }

        #region Register

        private const string DefaultMemberType = "Member";
        private const string DefaultMemberTypeAlias = "Member";
        private const string RegularMemberGroup = "Regular";
        private const string GeneratedToken = "token";
        private const int RegisteredMemberId = 123;

        [Test]
        public void UserRegistration_Register_ValtechUkUserType_MemberCreated_PasswordSaved_ConfirmationEmailSent()
        {
            // Arrange & Act & Assert
            UserToRegister user = GetUserToRegister(isValtechUkEmail: true);
            UserRegistration_Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(user);
        }

        [Test]
        public void UserRegistration_Register_OtherUserType_MemberCreated_PasswordSaved_ConfirmationEmailSent()
        {
            // Arrange & Act & Assert
            UserToRegister user = GetUserToRegister(isValtechUkEmail: false);
            UserRegistration_Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(user);
        }

        private void UserRegistration_Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(UserToRegister user)
        {
            ReturnDefaultMemberType();
            IMember registeredUser = GetRegisteredMember(user);

            _tokenGenerator.Generate().Returns(GeneratedToken);
            _memberService.CreateMemberWithIdentity(user.Username, user.Email, user.Name, DefaultMemberTypeAlias).Returns(registeredUser);

            // Act
            _userRegistration.Register(user);

            // Assert
            AssertIfMemberWasCreated(user, registeredUser, shouldBeApproved: user.Type == UserType.ValtechUk);
            AsserrIfConfirmationDataWasSaved();
            AssertIfConfirmationEmailWasSent();
        }

        private IMember GetRegisteredMember(UserToRegister user)
        {
            IMember registeredMember = Substitute.For<IMember>();
            registeredMember.Id = RegisteredMemberId;
            registeredMember.Email = user.Email;

            return registeredMember;
        }

        private void ReturnDefaultMemberType()
        {
            IMemberType memberType = Substitute.For<IMemberType>();
            memberType.Alias = DefaultMemberTypeAlias;
            _memberTypeService.Get(DefaultMemberType).Returns(memberType);
        }

        private void AssertIfMemberWasCreated(UserToRegister user, IMember registeredUser, bool shouldBeApproved)
        {
            _memberService.Received(1).CreateMemberWithIdentity(user.Username, user.Email, user.Name, DefaultMemberType);
            _memberService.Received(1).SavePassword(Arg.Is<IMember>(m => m.IsApproved == shouldBeApproved), user.Password);
            _memberService.Received(1).Save(registeredUser);
            _memberService.Received(1).AssignRole(registeredUser.Id, RegularMemberGroup);
        }

        private void AsserrIfConfirmationDataWasSaved()
        {
            _accountRepository.Received(1).Save(Arg.Is<UserAccountDto>(a =>
                a.UserId == RegisteredMemberId &&
                a.ConfirmationToken == GeneratedToken &&
                a.ConfirmationExpirationDate > DateTime.UtcNow));
        }

        private void AssertIfConfirmationEmailWasSent()
        {
            _emailSender.Received(1).Send(Arg.Is<RegistrationEmailMessage>(r =>
                r != null &&
                r.IsBodyHtml &&
                !string.IsNullOrEmpty(r.Subject) &&
                !string.IsNullOrEmpty(r.Body)));
        }

        private UserToRegister GetUserToRegister(bool isValtechUkEmail) => new UserToRegister(new UserRegistrationViewModel
        {
            Name = "name",
            Password = "password",
            Email = string.Format("email@{0}", isValtechUkEmail ? "valtech.co.uk" : "other.com"),
            Username = "username"
        });

        #endregion
    }
}