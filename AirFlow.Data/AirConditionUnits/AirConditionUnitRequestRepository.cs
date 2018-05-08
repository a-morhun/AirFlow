using System;
using PetaPoco;

namespace AirFlow.Data.AirConditionUnits
{
    internal class AirConditionUnitRequestRepository : IAirConditionUnitRequestRepository
    {
        public AirConditionUnitRequestDto[] Get(string airConditionUnitId)
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

                try
                {
                    return db.Fetch<AirConditionUnitRequestDto>(sql).ToArray();
                }
                catch (Exception e)
                {
                    throw new AirConditionUnitRepositoryException($"Failed to retreive history for unit {airConditionUnitId}", e);
                }

            }
        }

        public void Save(AirConditionUnitRequestDto request)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                try
                {
                    db.Insert(request);
                }
                catch (Exception ex)
                {
                    throw new AirConditionUnitRepositoryException("Failed to save temperature request", ex);
                }
            }
        }
    }
}