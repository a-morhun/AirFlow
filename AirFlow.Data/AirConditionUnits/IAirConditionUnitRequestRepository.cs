namespace AirFlow.Data.AirConditionUnits
{
    public interface IAirConditionUnitRequestRepository
    {
        AirConditionUnitRequestDto[] Get(int airConditionUnitId);
    }
}