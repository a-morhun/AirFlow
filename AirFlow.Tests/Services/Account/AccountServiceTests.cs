using AirFlow.Models.Account;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using NUnit.Framework;
using NSubstitute;
using System;
using System.Linq.Expressions;
using Umbraco.Core.Services;
using Umbraco.Core.Models;

namespace AirFlow.Tests.Services.Account
{
    [TestFixture]
    public class AccountServiceTests
    {
        private IMemberService _memberService;
        private IUserRegistration _userRegistration;
        private IAccountService _accountService;

        [SetUp]
        public void SetUpOnce()
        {
            _memberService = Substitute.For<IMemberService>();
            _userRegistration = Substitute.For<IUserRegistration>();
            _accountService = new AccountService(_memberService, _userRegistration);
        }

        #region Register

        [Test]
        public void AccountService_Register_CanRegister_Success()
        {
            // Arrange
            IMember existedMember = null;
            UserToRegister user = GetUserToRegister();
            _memberService.GetByEmail(user.Email).Returns(existedMember);

            // Act
            Result registrationResult = _accountService.Register(user);

            // Assert
            Assert.IsNotNull(registrationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(registrationResult.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "registrationResult.IsSuccess"));
            _userRegistration.Received(1).Register(Arg.Is(RegistrationPredicate(user)));
        }

        [Test]
        public void AccountService_Register_CanNotRegister_Failure()
        {
            // Arrange
            IMember existedMember = Substitute.For<IMember>();
            ErrorCodeType expectedError = ErrorCodeType.MemberAlreadyExists;
            UserToRegister user = GetUserToRegister();
            _memberService.GetByEmail(user.Email).Returns(existedMember);

            // Act
            Result registrationResult = _accountService.Register(user);

            // Assert
            Assert.IsNotNull(registrationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(registrationResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "registrationResult.IsFailure"));
            Assert.AreEqual(expectedError, registrationResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedError, registrationResult.ErrorCode));
            _userRegistration.ReceivedWithAnyArgs(0).Register(null);
        }

        [Test]
        public void AccountService_Register_RegistrationFailed_Failure()
        {
            // Arrange
            IMember existedMember = null;
            ErrorCodeType expectedError = ErrorCodeType.UnknownError;
            UserToRegister user = GetUserToRegister();
            _memberService.GetByEmail(user.Email).Returns(existedMember);
            UserRegistrationFailed(user);

            // Act
            Result registrationResult = _accountService.Register(user);

            // Assert
            Assert.IsNotNull(registrationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(registrationResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "registrationResult.IsFailure"));
            Assert.AreEqual(expectedError, registrationResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedError, registrationResult.ErrorCode));
            _userRegistration.Received(1).Register(Arg.Is(RegistrationPredicate(user)));
        }

        private UserToRegister GetUserToRegister() => new UserToRegister(new UserRegistrationViewModel
        {
            Name = "name",
            Password = "password",
            Email = "email",
            Username = "username"
        });

        private void UserRegistrationFailed(UserToRegister user) =>
            _userRegistration
                .When(x => x.Register(Arg.Is(RegistrationPredicate(user))))
                .Do(x => throw new Exception());

        private Expression<Predicate<UserToRegister>> RegistrationPredicate(UserToRegister user) =>
            u => u.Email == user.Email &&
                 u.Name == user.Name &&
                 u.Password == user.Password &&
                 u.Username == user.Username;

        #endregion
    }
}