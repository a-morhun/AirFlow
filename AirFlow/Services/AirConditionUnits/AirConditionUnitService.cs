using AirFlow.Data.AirConditionUnits;
using AirFlow.Models.Common;
using AirFlow.Services.Email;
using System.Linq;

namespace AirFlow.AirConditionUnits
{
    internal class AirConditionUnitService : IAirConditionUnitService
    {
        private readonly IAirConditionUnitRequestRepository _repository;
        private readonly IEmailSender _emailSender;

        public AirConditionUnitService(IAirConditionUnitRequestRepository repository, IEmailSender emailSender)
        {
            _repository = repository;
            _emailSender = emailSender;
        }

        public Result CreateRequest(string requesterEmail, TemperatureRequest request)
        {
            try
            {
                SendRequestEmail(requesterEmail, request);
                _repository.Save(new AirConditionUnitRequestDto
                {
                    AirConditionUnitId = request.AirConditionUnitId,
                    RequesterEmail = requesterEmail,
                    Temperature = request.Temperature,
                    UpdateDateTime = request.RequestDateTime.Value
                });

                return Result.Success;
            }
            catch
            {
                return new Result(ErrorCodeType.UnknownError);
            }

        }

        private void SendRequestEmail(string requesterEmail, TemperatureRequest request)
        {
            string sendTo = "a@a.com";
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
            catch
            {
                return new Result<TemperatureRequestHistory[]>(ErrorCodeType.UnknownError);
            }

            var history = historyDto.Select(h => new TemperatureRequestHistory(h, AirFlowConstants.UkTimeZone)).ToArray();
            return new Result<TemperatureRequestHistory[]>(history);
        }
    }
}