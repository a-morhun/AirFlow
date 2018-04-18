using AirFlow.Controllers;
using AirFlow.Models.Account;
using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Account;
using NUnit.Framework;
using NSubstitute;
using System;
using System.Linq.Expressions;
using System.Web.Mvc;

namespace AirFlow.Tests.Controllers
{
    [TestFixture]
    public class AccountSurfaceControllerTests
    {
        private IAccountService _accountService;
        private AccountSurfaceController _accountController;

        [SetUp]
        public void SetUpOnce()
        {
            Common.SetUpUmbracoContext();

            _accountService = Substitute.For<IAccountService>();
            _accountController = new AccountSurfaceController(_accountService);
        }

        [TearDown]
        public void TearDown()
        {
            Common.DisposeUmbracoContext();
        }

        #region Registration

        [Test]
        public void AccountSurfaceController_Register_ValidUserInfo_Success()
        {
            // Arrange
            UserRegistrationViewModel registrationRequest = GetUserRegistrationViewModel($"mock@{Common.ValtechUkDomain}");
            MockSuccessServiceRegisterMethod(registrationRequest);

            // Act
            var result = _accountController.Register(registrationRequest) as PartialViewResult;

            // Assert
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            Assert.IsTrue(model.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsSuccess"));
        }

        [Test]
        public void AccountSurfaceController_Register_ValidUserInfoAndServiceFailedToSave_Failure()
        {
            // Arrange
            UserRegistrationViewModel registrationRequest = GetUserRegistrationViewModel($"mock@{Common.ValtechUkDomain}");
            MockFailureServiceRegisterMethod(registrationRequest, ErrorCodeType.UnknownError);

            // Act
            var result = _accountController.Register(registrationRequest) as PartialViewResult;

            // Assert
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            Assert.IsTrue(model.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsFailure"));
        }

        [Test]
        public void AccountSurfaceController_Register_InvalidRegistrationRequest_Failure()
        {
            // Arrange
            _accountController.ModelState.AddModelError("error", new Exception());

            // Act
            var result = _accountController.Register(Arg.Any<UserRegistrationViewModel>()) as PartialViewResult;

            // Assert
            var model = Common.AssertPartialViewResult<ResultViewModel>(result);
            _accountService.ReceivedWithAnyArgs(0).Register(null);
            Assert.IsTrue(model.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "model.IsFailure"));
        }

        private UserRegistrationViewModel GetUserRegistrationViewModel(string email) =>
            new UserRegistrationViewModel
            {
                Email = email,
                Password = "password",
                Username = "username",
                LoginType = LoginType.TwoFactorEmail
            };

        private void MockSuccessServiceRegisterMethod(UserRegistrationViewModel registrationRequest)
        {
            _accountService.Register(Arg.Is(ServiceRegistrationPredicate(registrationRequest))).Returns(Result.Success);
        }

        private void MockFailureServiceRegisterMethod(UserRegistrationViewModel registrationRequest, ErrorCodeType errorCode)
        {
            _accountService.Register(Arg.Is(ServiceRegistrationPredicate(registrationRequest))).Returns(new Result(errorCode));
        }

        private static Expression<Predicate<UserToRegister>> ServiceRegistrationPredicate(UserRegistrationViewModel registrationRequest) =>
            r => r.Email == registrationRequest.Email &&
                 r.Password == registrationRequest.Password &&
                 r.Username == registrationRequest.Username &&
                 r.LoginType == LoginType.TwoFactorEmail;
    }

    #endregion
}