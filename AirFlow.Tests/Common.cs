using AirFlow.Models.Common;
using NSubstitute;
using NUnit.Framework;
using System;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Core;
using Umbraco.Core.Configuration.UmbracoSettings;
using Umbraco.Core.Logging;
using Umbraco.Core.Profiling;
using Umbraco.Web;
using Umbraco.Web.Mvc;
using Umbraco.Web.Routing;
using Umbraco.Web.Security;

namespace AirFlow.Tests
{
    public class Common
    {
        public const string ValtechUkDomain = "valtech.co.uk";
        public const string DefaultMemberType = "Member";
        public const string RegularMemberGroup = "Regular";
        public const string TimeZone = "GMT Standard Time";

        private const string ResponseTypeMismatchFormat = "Response is not type of {0} or missing at all";
        private const string NotSatisfiedExpectation = "Expected {0} for {1}";

        public static string ShowResponseTypeMismatchMessage(Type type) => string.Format(ResponseTypeMismatchFormat, type.Name);
        public static string ShowNotSatisfiedExpectationMessage<T>(T expected, object target) => string.Format(NotSatisfiedExpectation, expected, target);

        public static void SetUpUmbracoContext(IUrlProvider provider = null)
        {
            var applicationContext = new ApplicationContext(
                CacheHelper.CreateDisabledCacheHelper(),
                new ProfilingLogger(Substitute.For<ILogger>(), Substitute.For<IProfiler>()));

            UmbracoContext.EnsureContext(
                Substitute.For<HttpContextBase>(),
                applicationContext,
                new WebSecurity(Substitute.For<HttpContextBase>(), applicationContext),
                Substitute.For<IUmbracoSettingsSection>(),
                provider == null ? Enumerable.Empty<IUrlProvider>() : new[] { provider },
                true);
        }

        public static void DisposeUmbracoContext()
        {
            UmbracoContext.Current.Dispose();
        }

        public static void AssertViewResult(ViewResult result, string expectedViewName)
        {
            Assert.IsNotNull(result, ShowResponseTypeMismatchMessage(typeof(ViewResult)));
            Assert.AreEqual(expectedViewName, result.ViewName);
        }

        public static void AssertRedirectToUmbracoPageResult(RedirectToUmbracoPageResult result, int expectedPageId)
        {
            Assert.IsNotNull(result, ShowResponseTypeMismatchMessage(typeof(RedirectToUmbracoPageResult)));
            Assert.AreEqual(expectedPageId, result.PageId);
        }

        public static T AssertPartialViewResult<T>(PartialViewResult result) where T : class
        {
            Assert.IsNotNull(result, ShowResponseTypeMismatchMessage(typeof(PartialViewResult)));
            T viewModel = result.Model as T;
            Assert.IsNotNull(viewModel, ShowResponseTypeMismatchMessage(typeof(ResultViewModel)));

            return viewModel;
        }

        public static void AssertRedirectResult(RedirectResult result, string expectedUrl)
        {
            Assert.IsNotNull(result, ShowResponseTypeMismatchMessage(typeof(RedirectResult)));
            string url = result.Url;
            Assert.IsNotNull(url, ShowNotSatisfiedExpectationMessage(expectedUrl, url));
        }

        public static void AssertResult(Result result, bool isSuccess)
        {
            Assert.IsNotNull(result, Common.ShowResponseTypeMismatchMessage(typeof(Result)));

            if (isSuccess)
            {
                Assert.IsTrue(result.IsSuccess, Common.ShowNotSatisfiedExpectationMessage(true, "result.IsSuccess"));
                return;
            }

            Assert.IsTrue(result.IsFailure, Common.ShowNotSatisfiedExpectationMessage(true, "result.IsFailure"));
        }
    }
}
