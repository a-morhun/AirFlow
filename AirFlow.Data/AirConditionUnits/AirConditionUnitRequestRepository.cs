using PetaPoco;

namespace AirFlow.Data.AirConditionUnits
{
    internal class AirConditionUnitRequestRepository : IAirConditionUnitRequestRepository
    {
        public AirConditionUnitRequestDto[] Get(int airConditionUnitId)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("id," +
                            "acu_id," +
                            "requester_email," +
                            "temperature," +
                            "update_datetime")
                    .From("airFlowACURequests")
                    .Where("acu_id = @0", airConditionUnitId);

                return db.Fetch<AirConditionUnitRequestDto>(sql).ToArray();
            }
        }

        public void Save(AirConditionUnitRequestDto request)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                db.Insert(request);
            }
        }
    }
}