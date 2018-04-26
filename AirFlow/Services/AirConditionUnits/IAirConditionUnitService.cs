using AirFlow.Models.Common;

namespace AirFlow.AirConditionUnits
{
    public interface IAirConditionUnitService
    {
        Result CreateRequest(string requesterEmail, TemperatureRequest request);

        Result<TemperatureRequestHistory[]> GetRequestHistory(int airConditionUnitId);
    }
}