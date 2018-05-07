using AirFlow.AirConditionUnits;
using AirFlow.Controllers;
using AirFlow.Data.AirConditionUnits;
using AirFlow.Models.Common;
using NSubstitute;
using NUnit.Framework;
using System;
using System.Web.Http.Results;

namespace AirFlow.Tests.Controllers
{
    [TestFixture]
    public class AirConditionUnitsControllerTests
    {
        private IAirConditionUnitService _airConditionUnitService;
        private AirConditionUnitsController _controller;

        [SetUp]
        public void SetUp()
        {
            Common.SetUpUmbracoContext();
            _airConditionUnitService = Substitute.For<IAirConditionUnitService>();

            _controller = new AirConditionUnitsController(_airConditionUnitService);
        }

        #region Create temperature request

        [Test]
        public void AirConditionUnitsController_CreateTemperatureRequest_ValidRequest_Success()
        {
            // Arrange
            var request = GetValidTemperatureRequest();
            _airConditionUnitService.CreateRequest(
                    Arg.Any<string>(),
                    Arg.Is<TemperatureRequest>(r => r.AirConditionUnitId == request.AirConditionUnitId &&
                                                    r.AirConditionUnitName == request.AirConditionUnitName &&
                                                    r.Temperature == request.Temperature))
                .Returns(new Result());

            // Act
            var result = _controller.CreateTemperatureRequest(request) as OkResult;

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(OkResult)));
        }

        [Test]
        [TestCase(null, "Name", 14)]
        [TestCase("abc", "", 14)]
        [TestCase("abc", null, 14)]
        [TestCase("abc", "Name", -1)]
        public void AirConditionUnitsController_CreateTemperatureRequest_InValidRequest_BadRequest(
            string airConditionUnitId,
            string airConditionUnitName,
            decimal temperature)
        {
            // Arrange
            var request = new TemperatureRequest
            {
                AirConditionUnitId = airConditionUnitId,
                AirConditionUnitName = airConditionUnitName,
                Temperature = temperature
            };

            // Act
            var result = _controller.CreateTemperatureRequest(request) as BadRequestResult;

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(BadRequestResult)));
        }

        [Test]
        public void AirConditionUnitsController_CreateTemperatureRequest_ValidRequest_ServiceFailure_InternalError()
        {
            // Arrange
            var request = GetValidTemperatureRequest();
            _airConditionUnitService.CreateRequest(Arg.Any<string>(), Arg.Any<TemperatureRequest>())
                .Returns(new Result(ErrorCodeType.UnknownError));

            // Act
            var result = _controller.CreateTemperatureRequest(request) as InternalServerErrorResult;

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(InternalServerErrorResult)));
        }

        private TemperatureRequest GetValidTemperatureRequest() => new TemperatureRequest
        {
            AirConditionUnitId = "abc",
            AirConditionUnitName = "Name",
            Temperature = 14
        };

        #endregion

        #region  Get temperature request history

        [Test]
        public void GetTemperatureRequestHistory_Success()
        {
            // Arrange
            const string airConditionUnitId = "abc";
            var history = new[]
            {
                new TemperatureRequestHistory(new AirConditionUnitRequestDto
                {
                    AirConditionUnitId = airConditionUnitId,
                    RequesterEmail = "email",
                    Temperature = 14,
                    Id = 5,
                    UpdateDateTime = DateTime.UtcNow
                }, Common.TimeZone)
            };

            _airConditionUnitService.GetRequestHistory(airConditionUnitId)
                .Returns(new Result<TemperatureRequestHistory[]>(history));

            // Act
            var result = _controller.GetTemperatureRequestHistory(airConditionUnitId) as OkNegotiatedContentResult<TemperatureRequestHistoryResponse>;

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(OkNegotiatedContentResult<TemperatureRequestHistoryResponse>)));
            Assert.AreEqual(history.Length, result.Content.History.Length);
        }

        [Test]
        public void GetTemperatureRequestHistory_ServiceFailure_InternalError()
        {
            // Arrange
            const string airConditionUnitId = "abc";
            _airConditionUnitService.GetRequestHistory(airConditionUnitId)
                .Returns(new Result<TemperatureRequestHistory[]>(ErrorCodeType.UnknownError));

            // Act
            var result = _controller.GetTemperatureRequestHistory(airConditionUnitId) as InternalServerErrorResult;

            // Assert
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(InternalServerErrorResult)));
        }

        #endregion
    }
}
