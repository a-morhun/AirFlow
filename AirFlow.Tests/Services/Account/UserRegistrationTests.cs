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
    [TestFixture(TestName = "User registration tests")]
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

        [Test(Description = "A member filled up and sent a registration form")]
        public void Register_ValtechUkUserType_MemberCreated_PasswordSaved_ConfirmationEmailSent()
        {
            // Arrange & Act & Assert
            UserToRegister user = GetUserToRegister(isValtechUkEmail: true);
            Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(user);
        }

        [Test(Description = "A member filled up and sent a registration form")]
        public void Register_OtherUserType_MemberCreated_PasswordSaved_ConfirmationEmailSent()
        {
            // Arrange & Act & Assert
            UserToRegister user = GetUserToRegister(isValtechUkEmail: false);
            Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(user);
        }

        [Test(Description = "A member was added in the backoffice. Confirmation email message was sent")]
        public void CompleteRegistrationFromBackoffice_Successful_ConfirmationEmailSent()
        {
            // Arrange
            const string userEmail = "email@user.com";
            var member = Substitute.For<IMember>();
            member.Id.Returns(RegisteredMemberId);
            member.Email.Returns(userEmail);
            _tokenGenerator.Generate().Returns(GeneratedToken);

            // Act
            _userRegistration.CompleteRegistrationFromBackoffice(member);

            // Assert
            AsserrIfConfirmationDataWasSaved();
            AssertIfConfirmationEmailWasSent(userEmail);
        }

        private void Register_MemberCreated_PasswordSaved_ConfirmationEmailSent(UserToRegister user)
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
            AssertIfConfirmationEmailWasSent(user.Email);
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
            var expected = UserAccountDtoResemblance.Construct(RegisteredMemberId, GeneratedToken, DateTime.UtcNow);
            _accountRepository.Received(1).Save(Arg.Is<UserAccountDto>(a => expected.Equals(a)));
        }

        private void AssertIfConfirmationEmailWasSent(string userEmail)
        {
            var expected = new ConfirmationEmailMessageOptionsResemblance(userEmail, GeneratedToken, DateTime.Now);

            _emailSender.Received(1).Send(EmailMessageType.EmailConfirmation,
                Arg.Is<ConfirmationEmailMessageOptions>(o => expected.Equals(o)));
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