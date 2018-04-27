using AirFlow.Extensions;
using AirFlow.Models.Common;
using System.Net.Mail;
using System.Text;

namespace AirFlow.Services.Email
{
    internal class TemperatureRequestEmailMessage : MailMessage
    {
        // TODO: Design and move template into Umbraco
        private const string BodyTemplate =
            "<p>Temperature change request</p>" +
            "<p>Air-condition unit: {0}</p>" +
            "<p>Temperature: {1}</p>" +
            "<p>Requester: {2}</p>" +
            "<p>{3}</p>";

        public TemperatureRequestEmailMessage(TemperatureRequestEmailMessageOptions options)
        {
            To.Add(options.SendTo);
            Subject = "AirFlow login confirmation";
            IsBodyHtml = true;
            BodyEncoding = Encoding.UTF8;

            Body = string.Format(BodyTemplate,
                options.AirConditionUnitName,
                options.Temperature,
                options.RequesterEmail,
                options.RequestDateTime.ToStringWithTimeZone(AirFlowConstants.UkTimeZone));
        }
    }
}