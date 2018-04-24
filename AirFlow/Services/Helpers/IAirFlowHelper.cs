using AirFlow.Models.Common;
using Umbraco.Core.Models;

namespace AirFlow.Services.Helpers
{
    public interface IAirFlowHelper
    {
        IContent GetContent(string contentName, int level = AirFlowConstants.RootContentLevel);

        int GetContentId(string contentName, int level = AirFlowConstants.RootContentLevel);
    }
}