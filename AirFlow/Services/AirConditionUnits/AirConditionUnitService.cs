using AirFlow.Data.AirConditionUnits;
using AirFlow.Models.Common;
using AirFlow.Services.Email;
using AirFlow.Services.Helpers;
using AirFlow.Utilities;
using System;
using System.Linq;

namespace AirFlow.AirConditionUnits
{
    internal class AirConditionUnitService : IAirConditionUnitService
    {
        private readonly IAirConditionUnitRequestRepository _repository;
        private readonly IEmailSender _emailSender;
        private readonly IAirFlowHelper _airFlowHelper;

        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AirConditionUnitService));

        public AirConditionUnitService(
            IAirConditionUnitRequestRepository repository, 
            IEmailSender emailSender,
            IAirFlowHelper airFlowHelper)
        {
            _repository = repository;
            _emailSender = emailSender;
            _airFlowHelper = airFlowHelper;
        }

        public Result CreateRequest(string requesterEmail, TemperatureRequest request)
        {
            try
            {
                SendRequestEmail(requesterEmail, request);
                var requestDto = new AirConditionUnitRequestDto
                {
                    AirConditionUnitId = request.AirConditionUnitId,
                    RequesterEmail = requesterEmail,
                    Temperature = request.Temperature,
                    UpdateDateTime = request.RequestDateTime.Value
                };

                _logger.Debug(requestDto.ToString());
                _repository.Save(requestDto);

                return Result.Success;
            }
            catch (Exception e)
            {
                _logger.Error("Failed to create request", e);
                return new Result(ErrorCodeType.UnknownError);
            }

        }

        private void SendRequestEmail(string requesterEmail, TemperatureRequest request)
        {
            // TODO: Uncomment when homepage will be integrated into Umbraco
            //string sendTo = _airFlowHelper.GetSingleContentPropertyValue<string>("Home", "SendRequestTo");
            string sendTo = "a@a.com";
            _logger.Debug($"SendRequestTo: {sendTo}");
            var options = new TemperatureRequestEmailMessageOptions(
                sendTo,
                request.AirConditionUnitName,
                requesterEmail,
                request.Temperature,
                request.RequestDateTime.Value);

            _emailSender.Send(EmailMessageType.TemperatureChangeRequest, options);
        }

        public Result<TemperatureRequestHistory[]> GetRequestHistory(int airConditionUnitId)
        {
            AirConditionUnitRequestDto[] historyDto;

            try
            {
                historyDto = _repository.Get(airConditionUnitId);
            }
            catch (Exception e)
            {
                _logger.Error("Failed to retreive history", e);
                return new Result<TemperatureRequestHistory[]>(ErrorCodeType.UnknownError);
            }

            var history = historyDto.Select(h => new TemperatureRequestHistory(h, AirFlowConstants.UkTimeZone)).ToArray();
            return new Result<TemperatureRequestHistory[]>(history);
        }
    }
}