using AirFlow.Models.Common;
using Umbraco.Core.Models;
using Umbraco.Web;

namespace AirFlow.Services.Helpers
{
    public interface IAirFlowHelper
    {
        IContent GetContent(string contentName, int level = AirFlowConstants.RootContentLevel);

        int GetContentId(string contentName, int level = AirFlowConstants.RootContentLevel);

        string GetContentUrl(UmbracoContext context, string contentName, int level = AirFlowConstants.RootContentLevel);
    }
}