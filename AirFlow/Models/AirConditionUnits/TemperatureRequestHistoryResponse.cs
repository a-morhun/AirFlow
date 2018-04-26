using Newtonsoft.Json;

namespace AirFlow.AirConditionUnits
{
    public class TemperatureRequestHistoryResponse
    {
        [JsonProperty("history")]
        public TemperatureRequestHistory[] History { get; set; }

        public TemperatureRequestHistoryResponse(TemperatureRequestHistory[] history)
        {
            History = history;
        }
    }
}