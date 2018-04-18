using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System;
using NSubstitute;
using NUnit.Framework;

namespace AirFlow.Tests.Services.Auth
{
    [TestFixture]
    public class AuthServiceTests
    {
        private IMembership _membership;
        private IUserSecurityRepository _userSecurityRepository;
        private IAuthService _authService;

        [SetUp]
        public void SetUp()
        {
            _membership = Substitute.For<IMembership>();
            _userSecurityRepository = Substitute.For<IUserSecurityRepository>();

            _authService = new AuthService(_membership, _userSecurityRepository);
        }

        #region Login

        private const string Username = "username";

        [Test]
        public void AuthService_Login_ExistingUser_ValidCredentialsAndUserApproved_ConfirmedEmail_Success()
        {
            // Arrange
            UserToLogin user = GetUserToLogin();
            ReturnNonEmptyUsername(user.Email);
            ReturnValidUserValue(Username, user.Password);
            ReturnConfirmedEmailValue(user.Email);

            // Act
            LoginResult loginResult = _authService.Login(user);

            // Assert
            Assert.IsNotNull(loginResult, Common.ShowResponseTypeMismatchMessage(typeof(LoginResult)));
            Assert.IsTrue(loginResult.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "loginResult.IsSuccess"));
            Assert.AreEqual(Username, loginResult.Username, Common.ShowNotSatisfiedExpectationMessage(Username, loginResult.Username));
        }

        [Test]
        public void AuthService_Login_UserDoesNotExist_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.MemberNotFound;
            UserToLogin user = GetUserToLogin();

            // Act
            LoginResult loginResult = _authService.Login(user);

            // Assert
            AssertExpectedFailureResultForLogin(loginResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_Login_ExistingUser_InvalidCredentialsOrUserIsNotApproved_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.MemberIsNotApprovedOrInvalidCredentials;
            UserToLogin user = GetUserToLogin();
            ReturnNonEmptyUsername(user.Email);
            ReturnInvalidUserValue(Username, user.Password);

            // Act
            LoginResult loginResult = _authService.Login(user);

            // Assert
            AssertExpectedFailureResultForLogin(loginResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_Login_ExistingUser_ValidCredentialsAndUserApproved_EmailWanNotConfirmed_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.MemberHasNotConfirmedEmail;
            UserToLogin user = GetUserToLogin();
            ReturnNonEmptyUsername(user.Email);
            ReturnValidUserValue(Username, user.Password);
            ReturnNotConfirmedEmailValue(user.Email);

            // Act
            LoginResult loginResult = _authService.Login(user);

            // Assert
            AssertExpectedFailureResultForLogin(loginResult, expectedErrorCode);
        }

        private void AssertExpectedFailureResultForLogin(LoginResult loginResult, ErrorCodeType expectedErrorCode)
        {
            Assert.IsNotNull(loginResult, Common.ShowResponseTypeMismatchMessage(typeof(LoginResult)));
            Assert.IsTrue(loginResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "loginResult.IsFailure"));
            Assert.AreEqual(expectedErrorCode, loginResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedErrorCode, loginResult.ErrorCode));
        }

        private UserToLogin GetUserToLogin() => new UserToLogin(new UserLoginViewModel
        {
            Email = "email",
            Password = "password"
        });

        private void ReturnNonEmptyUsername(string email) =>
            _membership.GetUserNameByEmail(email).Returns(Username);

        private void ReturnValidUserValue(string username, string password) =>
            _membership.ValidateUser(username, password).Returns(true);

        private void ReturnInvalidUserValue(string username, string password) =>
            _membership.ValidateUser(username, password).Returns(false);

        private void ReturnConfirmedEmailValue(string email) =>
            _userSecurityRepository.IsEmailConfirmed(email).Returns(true);

        private void ReturnNotConfirmedEmailValue(string email) =>
            _userSecurityRepository.IsEmailConfirmed(email).Returns(false);

        #endregion

        #region Confirm Email

        private const int UserId = 1;
        private const string Token = "token";

        [Test]
        public void AuthService_ConfirmEmail_ValidToken_NewConfirmation_Success()
        {
            // Arrange
            ConfirmationToken validToken = GetConfirmationToken(UserId);
            ReturnConfirmationToken(validToken);

            // Act
            Result confirmationResult = _authService.ConfirmEmail(Token);

            // Assert
            Assert.IsNotNull(confirmationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(confirmationResult.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "confirmationResult.IsSuccess"));
            _userSecurityRepository.Received(1).ConfirmEmail(UserId);
        }

        [Test]
        public void AuthService_ConfirmEmail_TokenNotFound_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.ConfirmationTokenInfoNotFound;
            ConfirmationToken invalidToken = null;
            ReturnConfirmationToken(invalidToken);

            // Act
            Result confirmationResult = _authService.ConfirmEmail(Token);

            // Assert
            AssertExpectedFailureResultForConfirmEmail(confirmationResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_ConfirmEmail_TokenAlreadyUsed_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.MemberHasAlreadyConfirmedEmail;
            ConfirmationToken invalidToken = GetConfirmationToken(UserId, confirmed: true);
            ReturnConfirmationToken(invalidToken);

            // Act
            Result confirmationResult = _authService.ConfirmEmail(Token);

            // Assert
            AssertExpectedFailureResultForConfirmEmail(confirmationResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_ConfirmEmail_TokenIsExpired_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.ConfirmationTokenIsExpired;
            ConfirmationToken invalidToken = GetConfirmationToken(UserId, expired: true);
            ReturnConfirmationToken(invalidToken);

            // Act
            Result confirmationResult = _authService.ConfirmEmail(Token);

            // Assert
            AssertExpectedFailureResultForConfirmEmail(confirmationResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_ConfirmEmail_ValidToken_ConfirmationFailed_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.UnknownError;
            ConfirmationToken valid = GetConfirmationToken(UserId);
            ReturnConfirmationToken(valid);
            EmailConfirmationFailed(UserId);

            // Act
            Result confirmationResult = _authService.ConfirmEmail(Token);

            // Assert
            AssertExpectedFailureResultForConfirmEmail(confirmationResult, expectedErrorCode, numberOfCalls: 1);
        }

        private ConfirmationToken GetConfirmationToken(int userId, bool confirmed = false, bool expired = false) => new ConfirmationToken
        {
            AlreadyConfirmed = confirmed,
            ExpirationDate = DateTime.UtcNow.AddDays(expired ? -1 : 1),
            UserId = userId
        };

        private void EmailConfirmationFailed(int userId) => _userSecurityRepository
            .When(x => x.ConfirmEmail(userId))
            .Do(x => throw new Exception());

        private void AssertExpectedFailureResultForConfirmEmail(Result confirmationResult, ErrorCodeType expectedErrorCode, int numberOfCalls = 0)
        {
            Assert.IsNotNull(confirmationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(confirmationResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "confirmationResult.IsFailure"));
            Assert.AreEqual(expectedErrorCode, confirmationResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedErrorCode, confirmationResult.ErrorCode));
            _userSecurityRepository.ReceivedWithAnyArgs(numberOfCalls).ConfirmEmail(UserId);
        }

        private void ReturnConfirmationToken(ConfirmationToken token) =>
            _userSecurityRepository.GetByConfirmationToken(Token).Returns(token);

        #endregion
    }
}