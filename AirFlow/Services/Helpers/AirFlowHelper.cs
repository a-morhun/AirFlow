using AirFlow.Services.Containers;
using System;
using System.Linq;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Web;

namespace AirFlow.Services.Helpers
{
    public class AirFlowHelper : IAirFlowHelper
    {
        private IContentService ContentService => AirFlowServiceContainer.Instance.GetInstance<IContentService>();
        private static readonly Lazy<AirFlowHelper> Lazy = new Lazy<AirFlowHelper>(() => new AirFlowHelper());

        public static AirFlowHelper Instance => Lazy.Value;

        private AirFlowHelper()
        {
        }

        public static UmbracoHelper UmbracoHelper => new UmbracoHelper(UmbracoContext.Current);

        public IContent GetContent(string contentName, int level) =>
            ContentService.GetByLevel(level).FirstOrDefault(c => c.Name == contentName);

        public int GetContentId(string contentName, int level) =>
            GetContent(contentName, level)?.Id ?? -1;

        public string GetContentUrl(UmbracoContext context, string contentName, int level)
        {
            IContent content = GetContent(contentName, level);
            return context.UrlProvider.GetUrl(content.Id);
        }

        public T GetSingleContentPropertyValue<T>(string contentName, string propertyAlias, int level)
        {
            int contentId = GetContentId(contentName, level);
            IPublishedContent publishedContent = UmbracoHelper.TypedContent(contentId);
            object value = publishedContent.Properties
                .Where(p => p.PropertyTypeAlias == propertyAlias)
                .Select(p => p.DataValue)
                .FirstOrDefault();

            return (T)value;
        }
    }
}