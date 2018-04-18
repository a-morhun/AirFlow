using AirFlow.Data;
using AirFlow.Data.Models;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Auth;
using System;
using AirFlow.ServiceContainers;
using Autofac;
using NSubstitute;
using NUnit.Framework;

namespace AirFlow.Tests.Services.Auth
{
    [TestFixture]
    public class AuthServiceTests
    {
        private IMembership _membership;
        private IAuthRepository _authRepository;
        private IAuthService _authService;
        private IUserRepository _userRepository;

        [SetUp]
        public void SetUp()
        {
            _membership = Substitute.For<IMembership>();
            _authRepository = Substitute.For<IAuthRepository>();
            _userRepository = Substitute.For<IUserRepository>();

            _authService = new AuthService(_membership, _authRepository, _userRepository);
        }

        #region Login

        private const string Username = "username";

        [Test]
        public void AuthService_Login_ExistingUser_ValidCredentialsAndUserApproved_ConfirmedEmail_RegularLoginType_Success()
        {
            // Arrange & Act & Assert
            LoginType expectedLoginType = LoginType.Regular;
            AuthService_Login_ValidLoginProcess(expectedLoginType);
        }

        [Test]
        public void AuthService_Login_ExistingUser_ValidCredentialsAndUserApproved_ConfirmedEmail_2FAEmailLoginType_Success()
        {
            // Arrange
            LoginType expectedLoginType = LoginType.TwoFactorEmail;

            var builder = new ContainerBuilder();
            builder.RegisterInstance(Substitute.For<ITwoFactorLoginProcessor>()).As<ITwoFactorLoginProcessor>();
            AirFlowServiceContainer.SetContainer(builder.Build());

            // Arrange & Act & Assert
            AuthService_Login_ValidLoginProcess(expectedLoginType);
        }

        private void AuthService_Login_ValidLoginProcess(LoginType type)
        {
            // Arrange
            LoginType expectedLoginType = type;
            UserToLogin user = GetUserToLogin();
            ReturnExistingAdditionalInfo(user.Email, type);
            ReturnValidUserValue(Username, user.Password);
            ReturnConfirmedEmailValue(user.Email);

            // Act
            LoginResult loginResult = _authService.Login(user);

            // Assert
            Assert.IsNotNull(loginResult, Common.ShowResponseTypeMismatchMessage(typeof(LoginResult)));
            Assert.IsTrue(loginResult.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "loginResult.IsSuccess"));
            Assert.AreEqual(expectedLoginType, loginResult.Type, Common.ShowNotSatisfiedExpectationMessage(expectedLoginType, loginResult.Type));
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
            ReturnExistingAdditionalInfo(user.Email);
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
            ReturnExistingAdditionalInfo(user.Email);
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

        private void ReturnExistingAdditionalInfo(string email, LoginType type = LoginType.Regular) =>
            _userRepository.GetAdditionalLoginInfo(email).Returns(new AdditionalLoginInfo
            {
                UserId = UserId,
                LoginType = (byte)type,
                Username = Username
            });

        private void ReturnValidUserValue(string username, string password) =>
            _membership.ValidateUser(username, password).Returns(true);

        private void ReturnInvalidUserValue(string username, string password) =>
            _membership.ValidateUser(username, password).Returns(false);

        private void ReturnConfirmedEmailValue(string email) =>
            _authRepository.IsEmailConfirmed(email).Returns(true);

        private void ReturnNotConfirmedEmailValue(string email) =>
            _authRepository.IsEmailConfirmed(email).Returns(false);

        #endregion

        private const int UserId = 1;
        private const string Token = "token";

        #region Confirm Email

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
            _authRepository.Received(1).ConfirmEmail(UserId);
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
            ForUserId = userId
        };

        private void EmailConfirmationFailed(int userId) => _authRepository
            .When(x => x.ConfirmEmail(userId))
            .Do(x => throw new Exception());

        private void AssertExpectedFailureResultForConfirmEmail(Result confirmationResult, ErrorCodeType expectedErrorCode, int numberOfCalls = 0)
        {
            Assert.IsNotNull(confirmationResult, Common.ShowResponseTypeMismatchMessage(typeof(Result)));
            Assert.IsTrue(confirmationResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "confirmationResult.IsFailure"));
            Assert.AreEqual(expectedErrorCode, confirmationResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedErrorCode, confirmationResult.ErrorCode));
            _authRepository.ReceivedWithAnyArgs(numberOfCalls).ConfirmEmail(UserId);
        }

        private void ReturnConfirmationToken(ConfirmationToken token) =>
            _authRepository.GetConfirmationTokenDetails(Token).Returns(token);

        #endregion

        #region Confirm Login

        [Test]
        public void AuthService_ConfirmLogin_ValidToken_Success()
        {
            // Arrange
            Token validToken = GetLoginToken(UserId);
            ReturnConfirmationLoginToken(validToken);
            LoginConfirmed(UserId);

            // Act
            LoginResult confirmationResult = _authService.ConfirmLogin(Token);

            // Assert
            Assert.IsNotNull(confirmationResult, Common.ShowResponseTypeMismatchMessage(typeof(LoginResult)));
            Assert.IsTrue(confirmationResult.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "confirmationResult.IsSuccess"));
            _authRepository.Received(1).ConfirmLogin(UserId);
            Assert.AreEqual(Username, confirmationResult.Username);
        }

        [Test]
        public void AuthService_ConfirmLogin_TokenNotFound_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.LoginTokenInfoNotFound;
            Token invalidToken = null;
            ReturnConfirmationLoginToken(invalidToken);

            // Act
            LoginResult confirmationResult = _authService.ConfirmLogin(Token);

            // Assert
            AssertExpectedFailureResultForConfirmLogin(confirmationResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_ConfirmLogin_TokenIsExpired_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.LoginTokenIsExpired;
            Token invalidToken = GetLoginToken(UserId, expired: true);
            ReturnConfirmationLoginToken(invalidToken);

            // Act
            LoginResult confirmationResult = _authService.ConfirmLogin(Token);

            // Assert
            AssertExpectedFailureResultForConfirmLogin(confirmationResult, expectedErrorCode);
        }

        [Test]
        public void AuthService_ConfirmLogin_ValidToken_ConfirmationFailed_Failure()
        {
            // Arrange
            ErrorCodeType expectedErrorCode = ErrorCodeType.UnknownError;
            Token valid = GetLoginToken(UserId);
            ReturnConfirmationLoginToken(valid);
            LoginConfirmationFailed(UserId);

            // Act
            LoginResult confirmationResult = _authService.ConfirmLogin(Token);

            // Assert
            AssertExpectedFailureResultForConfirmLogin(confirmationResult, expectedErrorCode, numberOfCalls: 1);
        }

        private Token GetLoginToken(int userId, bool expired = false) => new Token
        {
            ExpirationDate = DateTime.UtcNow.AddDays(expired ? -1 : 1),
            ForUserId = userId
        };

        private void LoginConfirmed(int userId) => _authRepository.ConfirmLogin(userId).Returns(Username);

        private void LoginConfirmationFailed(int userId) => _authRepository
            .When(x => x.ConfirmLogin(userId))
            .Do(x => throw new Exception());

        private void AssertExpectedFailureResultForConfirmLogin(LoginResult confirmationResult, ErrorCodeType expectedErrorCode, int numberOfCalls = 0)
        {
            Assert.IsNotNull(confirmationResult, Common.ShowResponseTypeMismatchMessage(typeof(LoginResult)));
            Assert.IsTrue(confirmationResult.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "confirmationResult.IsFailure"));
            Assert.AreEqual(expectedErrorCode, confirmationResult.ErrorCode, Common.ShowNotSatisfiedExpectationMessage(expectedErrorCode, confirmationResult.ErrorCode));
            _authRepository.ReceivedWithAnyArgs(numberOfCalls).ConfirmLogin(UserId);
        }

        private void ReturnConfirmationLoginToken(Token token) =>
            _authRepository.GetLoginTokenDetails(Token).Returns(token);

        #endregion
    }
}