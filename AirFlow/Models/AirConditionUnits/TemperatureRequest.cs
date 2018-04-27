using System;

namespace AirFlow.AirConditionUnits
{
    public class TemperatureRequest
    {
        public int AirConditionUnitId { get; set; }

        public string AirConditionUnitName { get; set; }

        public decimal Temperature { get; set; }

        public DateTime? RequestDateTime { get; set; }

        public bool IsInvalid()
        {
            return AirConditionUnitId <= 0 ||
                   string.IsNullOrEmpty(AirConditionUnitName) || 
                   Temperature < 0;
        }
    }
}