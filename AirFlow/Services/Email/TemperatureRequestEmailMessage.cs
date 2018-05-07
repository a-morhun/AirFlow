using AirFlow.Extensions;
using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal class TemperatureRequestEmailMessage : MailMessage
    {
        public TemperatureRequestEmailMessage(string bodyTemplate, TemperatureRequestEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = "AirFlow temperature request";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;

            Body = string.Format(bodyTemplate,
                options.AirConditionUnitName,
                options.Temperature,
                options.RequesterEmail,
                options.RequestDateTime.ToStringWithTimeZone(AirFlowConstants.UkTimeZone));
        }
    }
}