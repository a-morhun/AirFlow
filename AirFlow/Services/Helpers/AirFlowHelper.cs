using AirFlow.ServiceContainers;
using Autofac;
using System;
using System.Linq;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Web;
using Umbraco.Web.Routing;

namespace AirFlow.Services.Helpers
{
    public class AirFlowHelper : IAirFlowHelper
    {
        private IContentService ContentService => AirFlowServiceContainer.Container.Resolve<IContentService>();
        private static Lazy<AirFlowHelper> _lazy = new Lazy<AirFlowHelper>(() => new AirFlowHelper());

        public static AirFlowHelper Instance => _lazy.Value;
        
        AirFlowHelper()
        {
        }        

        public IContent GetContent(string contentName, int level) =>
            ContentService.GetByLevel(level).FirstOrDefault(c => c.Name == contentName);

        public int GetContentId(string contentName, int level) =>
            GetContent(contentName, level)?.Id ?? -1;

        public string GetContentUrl(UmbracoContext context, string contentName, int level)
        {
            IContent content = GetContent(contentName, level);
            return context.UrlProvider.GetUrl(content.Id);
        }
    }
}