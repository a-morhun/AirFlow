using AirFlow.AirConditionUnits;
using AirFlow.Data.AirConditionUnits;
using AirFlow.Models.Common;
using AirFlow.Services.Email;
using AirFlow.Services.Helpers;
using NSubstitute;
using NUnit.Framework;
using System;

namespace AirFlow.Tests.Services.AirConditionUnits
{
    [TestFixture]
    public class AirConditionUnitServiceTests
    {
        private IAirConditionUnitRequestRepository _repository;
        private IEmailSender _emailSender;
        private IAirConditionUnitService _airConditionUnitService;
        private IAirFlowHelper _airFlowHelper;

        [SetUp]
        public void SetUp()
        {
            _repository = Substitute.For<IAirConditionUnitRequestRepository>();
            _emailSender = Substitute.For<IEmailSender>();
            _airFlowHelper = Substitute.For<IAirFlowHelper>();

            _airConditionUnitService = new AirConditionUnitService(_repository, _emailSender, _airFlowHelper);
        }

        #region Create request

        private const string RequesterEmail = "user@user.com";

        [Test]
        public void CreateRequest_EmailSent_RequestStored_Success()
        {
            // Arrange
            TemperatureRequest request = GetValidTemperatureRequest();

            // Act
            Result result = _airConditionUnitService.CreateRequest(RequesterEmail, request);

            // Assert
            Common.AssertResult(result, isSuccess: true);
            AssertEmailSender(request, sendCalled: true);
            AssertRepository(request, saveCalled: true);
        }

        [Test]
        public void CreateRequest_EmailWasNotSent_RequestNotStored_InternalError()
        {
            // Arrange
            TemperatureRequest request = GetValidTemperatureRequest();
            _emailSender
                .When(x => x.Send(EmailMessageType.TemperatureChangeRequest, Arg.Any<TemperatureRequestEmailMessageOptions>()))
                .Do(x => throw new Exception());

            // Act
            Result result = _airConditionUnitService.CreateRequest(RequesterEmail, request);

            // Assert
            Common.AssertResult(result, isSuccess: false);
            AssertEmailSender(request, sendCalled: true);
            AssertRepository(request, saveCalled: false);
        }

        [Test]
        public void CreateRequest_EmailtSent_RequestNotStored_InternalError()
        {
            // Arrange
            TemperatureRequest request = GetValidTemperatureRequest();
            _repository
                .When(x => x.Save(Arg.Any<AirConditionUnitRequestDto>()))
                .Do(x => throw new Exception());

            // Act
            Result result = _airConditionUnitService.CreateRequest(RequesterEmail, request);

            // Assert
            Common.AssertResult(result, isSuccess: false);
            AssertEmailSender(request, sendCalled: true);
            AssertRepository(request, saveCalled: true);
        }

        private TemperatureRequest GetValidTemperatureRequest() => new TemperatureRequest
        {
            AirConditionUnitId = 1,
            AirConditionUnitName = "Name",
            Temperature = 14,
            RequestDateTime = DateTime.UtcNow
        };

        private void AssertEmailSender(TemperatureRequest request, bool sendCalled)
        {
            _emailSender.Received(sendCalled ? 1 : 0).Send(EmailMessageType.TemperatureChangeRequest,
                Arg.Is<TemperatureRequestEmailMessageOptions>(o =>
                    o != null &&
                    o.SendTo != RequesterEmail &&
                    o.Temperature == request.Temperature &&
                    o.AirConditionUnitName == request.AirConditionUnitName));
        }

        private void AssertRepository(TemperatureRequest request, bool saveCalled)
        {
            _repository.Received(saveCalled ? 1 : 0).Save(Arg.Is<AirConditionUnitRequestDto>(a =>
               a.RequesterEmail == RequesterEmail &&
               a.Temperature == request.Temperature &&
               a.AirConditionUnitId == request.AirConditionUnitId));
        }

        #endregion

        #region Get request history

        private const int AirConditionUnitId = 1;

        [Test]
        public void GetRequestHistory_Retrieved_Success()
        {
            // Assert
            var history = new[]
            {
                new AirConditionUnitRequestDto
                {
                    AirConditionUnitId = AirConditionUnitId,
                    RequesterEmail = "email",
                    Temperature = 14,
                    Id = 5,
                    UpdateDateTime = DateTime.UtcNow
                }
            };
            _repository.Get(AirConditionUnitId).Returns(history);

            // Act
            Result<TemperatureRequestHistory[]> result = _airConditionUnitService.GetRequestHistory(AirConditionUnitId);

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(Result<TemperatureRequestHistory[]>)));
            Assert.AreEqual(history.Length, result.ReturnObject.Length, Common.ShowNotSatisfiedExpectationMessage(1, "result.ReturnObject.Length"));
        }

        [Test]
        public void GetRequestHistory_RepositoryFailure_InternalError()
        {
            // Assert
            _repository.Get(AirConditionUnitId).Returns(x => throw new Exception());

            // Act
            Result<TemperatureRequestHistory[]> result = _airConditionUnitService.GetRequestHistory(AirConditionUnitId);

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(Result<TemperatureRequestHistory[]>)));
            Common.AssertResult(result, isSuccess: false);
        }

        #endregion
    }
}
