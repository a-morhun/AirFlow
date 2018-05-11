using AirFlow.Extensions;
using AirFlow.Data.AirConditionUnits;
using System;

namespace AirFlow.AirConditionUnits
{
    public class TemperatureRequestHistory
    {
        public string RequesterEmail { get; }

        public decimal Temperature { get; }

        public DateTime RequestDateTime { get; }

        public TemperatureRequestHistory(AirConditionUnitRequestDto dto, string timeZoneId)
        {
            RequesterEmail = dto.RequesterEmail;
            Temperature = dto.Temperature;
            RequestDateTime = dto.UpdateDateTime.ApplyTimeZone(timeZoneId);
        }

        public override string ToString()
        {
            return $"Requester: {RequesterEmail}, Temperature: {Temperature}, Date: {RequestDateTime}";
        }
    }
}