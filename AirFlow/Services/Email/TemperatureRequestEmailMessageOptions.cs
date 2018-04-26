using System;

namespace AirFlow.Services.Email
{
    internal class TemperatureRequestEmailMessageOptions : EmailMessageOptions
    {
        public string AirConditionUnitName { get; }

        public string RequesterEmail { get; }

        public decimal Temperature { get; }

        public DateTime RequestDateTime { get; set; }

        public TemperatureRequestEmailMessageOptions(
            string sendTo, 
            string airConditionUnitName, 
            string requesterEmail, 
            decimal temperature,
            DateTime requestDateTime) : base(sendTo)
        {
            AirConditionUnitName = airConditionUnitName;
            RequesterEmail = requesterEmail;
            Temperature = temperature;
            RequestDateTime = requestDateTime;
        }
    }
}