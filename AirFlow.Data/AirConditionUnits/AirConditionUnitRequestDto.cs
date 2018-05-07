using PetaPoco;
using System;

namespace AirFlow.Data.AirConditionUnits
{
    [TableName("airFlowACURequests")]
    [PrimaryKey("id")]
    public class AirConditionUnitRequestDto
    {
        [Column("id")]
        public int Id { get; set; }

        [Column("acu_id")]
        public Guid AirConditionUnitId { get; set; }

        [Column("requester_email")]
        public string RequesterEmail { get; set; }

        [Column("temperature")]
        public decimal Temperature { get; set; }

        [Column("update_datetime")]
        public DateTime UpdateDateTime { get; set; }

        public override string ToString()
        {
            return $"Id: {Id}, " +
                   $"UnitId: {AirConditionUnitId}, " +
                   $"Requester: {RequesterEmail}, " +
                   $"Temperature: {Temperature}, " +
                   $"Date: {UpdateDateTime}";
        }
    }
}