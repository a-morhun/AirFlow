using System.Configuration;

namespace AirFlow.Models.Common
{
    public class AirFlowConfiguration
    {
        public static string AirFlowUrl => ConfigurationManager.AppSettings["AirFlowUrl"];
    }
}