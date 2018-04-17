using AirFlow.Services.Auth;
using NUnit.Framework;

namespace AirFlow.Tests.Services.Auth
{
    [TestFixture]
    public class TokenGeneratorTests
    {
        private ITokenGenerator _tokenGenerator;

        [SetUp]
        public void SetUp()
        {
            _tokenGenerator = new TokenGenerator();
        }

        #region Generate

        [Test]
        public void TokenGenerator_GeneratedValidToken()
        {
            // Act
            var token = _tokenGenerator.Generate();

            // Assert
            Assert.IsNotNull(token);
            Assert.IsNotEmpty(token);
            Assert.IsFalse(token.Contains("/"));
            Assert.IsFalse(token.Contains("+"));
            Assert.IsFalse(token.EndsWith("="));
        }

        #endregion
    }
}