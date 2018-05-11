namespace AirFlow.Data.AirConditionUnits
{
    /// <exception cref="AirConditionUnitRepositoryException">Thrown when account repository failed to maintain data</exception>
    public interface IAirConditionUnitRequestRepository
    {
        AirConditionUnitRequestDto[] Get(string airConditionUnitId);

        void Save(AirConditionUnitRequestDto request);
    }
}