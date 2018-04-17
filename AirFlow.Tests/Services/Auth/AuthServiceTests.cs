using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AirFlow.Data;
using AirFlow.Services.Auth;
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

        [Test]
        public void AuthService_Login_ExistingUser_ValidCredentials_ConfirmedEmail_Success()
        {
            // Arrange

            // Act

            // Assert
            Assert.IsTrue(false);
        }

        #endregion

        #region Confirm Email

        [Test]
        public void AuthService_ConfirmEmail_ValidToken_NewConfirmation_Success()
        {
            // Arrange

            // Act

            // Assert
            Assert.IsTrue(false);
        }

        #endregion
    }
}
