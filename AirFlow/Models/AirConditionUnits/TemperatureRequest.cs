using System;

namespace AirFlow.AirConditionUnits
{
    public class TemperatureRequest
    {
        public string AirConditionUnitId { get; set; }

        public string AirConditionUnitName { get; set; }

        public decimal Temperature { get; set; }

        public DateTime? RequestDateTime { get; set; }

        public bool IsInvalid()
        {
            return string.IsNullOrEmpty(AirConditionUnitId) ||
                   string.IsNullOrEmpty(AirConditionUnitName) ||
                   Temperature < 0;
        }

        public override string ToString()
        {
            return $"Id: {AirConditionUnitId}, Name: {AirConditionUnitName}, Temperature: {Temperature}";
        }
    }
}