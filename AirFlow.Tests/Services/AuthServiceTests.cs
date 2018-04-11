using AirFlow.Services.Abstract;
using AirFlow.Services;
using AirFlow.Models.Common;
using AirFlow.Models.Auth;
using NUnit.Framework;
using NSubstitute;
using System;
using Umbraco.Core.Services;
using Umbraco.Core.Models;

namespace AirFlow.Tests.Services
{
    [TestFixture]
    public class AuthServiceTests
    {
        private IMemberService _memberService;
        private IMemberTypeService _memberTypeService;
        private IMember _member;
        private IAuthService _authService;

        [OneTimeSetUp]
        public void SetUpOnce()
        {
            _memberService = Substitute.For<IMemberService>();
            _memberTypeService = Substitute.For<IMemberTypeService>();

            _authService = new AuthService(_memberService, _memberTypeService);
        }

        [SetUp]
        public void SetUp()
        {
            _member = Substitute.For<IMember>();
        }

        #region Register

        [Test]
        public void Register_ValtechUkUser_RegisteredAndShouldAutologinResultReturned()
        {
            // Arrange
            var user = new UserRegistrationViewModel
            {
                Email = $"some@{Common.ValtechUkDomain}",
                Username = "username",
                Password = "password"
            };
            ArrangeNewUserCondition();
            _memberService.CreateMemberWithIdentity(user.Username, user.Email, user.Username, Common.DefaultMemberType).Returns(_member);

            // Act
            RegistrationResult result = _authService.Register(user) as RegistrationResult;

            // Assert
            Assert.IsNotNull(result);
            AssertMemberService(user.Password);
            Assert.IsTrue(result.ShouldAutoLogin);
        }

        [Test]
        public void Register_OtherUser_RegisteredAndShouldNotAutologinResultReturned()
        {
            // Arrange
            var user = new UserRegistrationViewModel
            {
                Email = "some@other.com",
                Username = "username",
                Password = "password"
            };
            ArrangeNewUserCondition();
            _memberService.CreateMemberWithIdentity(user.Username, user.Email, user.Username, Common.DefaultMemberType).Returns(_member);

            // Act
            RegistrationResult result = _authService.Register(user) as RegistrationResult;

            // Assert
            Assert.IsNotNull(result);
            AssertMemberService(user.Password);
            Assert.IsFalse(result.ShouldAutoLogin);
            Assert.IsFalse(_member.IsApproved);
        }

        private void AssertMemberService(string password)
        {
            _memberService.Received(1).SavePassword(Arg.Any<IMember>(), password);
            _memberService.Received(1).Save(Arg.Any<IMember>());
            _memberService.Received(1).AssignRole(Arg.Any<int>(), Common.RegularMemberGroup);
        }

        [Test]
        public void Register_MemberServiceThrowsException_UnknownErrorReturned()
        {
            // Arrange
            var expectedErrorCode = ErrorCodeType.UnknownError;
            ArrangeNewUserCondition();
            _memberService.CreateMemberWithIdentity(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>())
                .Returns(x => { throw new Exception(); });

            // Act
            Result result = _authService.Register(new UserRegistrationViewModel() { Email = string.Empty }) as Result;

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedErrorCode, result.ErrorCode);
        }

        [Test]
        public void Register_UserWithSameUsernameExists_ReturnMemberAlreadyExistsErrorCode()
        {
            // Assert
            var expectedErrorCode = ErrorCodeType.MemberAlreadyExists;
            _memberService.Exists(Arg.Any<string>()).Returns(true);

            // Act
            Result result = _authService.Register(new UserRegistrationViewModel() { Email = string.Empty });

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedErrorCode, result.ErrorCode);
        }

        [Test]
        public void Register_UserWithSameEmailExists_ReturnMemberAlreadyExistsErrorCode()
        {
            // Assert
            ErrorCodeType expectedErrorCode = ErrorCodeType.MemberAlreadyExists;
            _memberService.Exists(Arg.Any<string>()).Returns(false);
            _memberService.GetByEmail(Arg.Any<string>()).Returns(_member);

            // Act
            Result result = _authService.Register(new UserRegistrationViewModel() { Email = string.Empty });

            // Assert
            Assert.IsNotNull(result);
            Assert.AreEqual(expectedErrorCode, result.ErrorCode);
        }

        private void ArrangeNewUserCondition()
        {
            IMember member = null;
            _memberService.Exists(Arg.Any<string>()).Returns(false);
            _memberService.GetByEmail(Arg.Any<string>()).Returns(member);
        }

        #endregion
    }
}
