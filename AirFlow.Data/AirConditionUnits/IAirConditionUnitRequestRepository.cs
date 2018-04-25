namespace AirFlow.Data.AirConditionUnits
{
    public interface IAirConditionUnitRequestRepository
    {
        AirConditionUnitRequestDto[] Get(int airConditionUnitId);

        void Save(AirConditionUnitRequestDto request);
    }
}