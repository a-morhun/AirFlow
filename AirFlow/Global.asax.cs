using AirFlow.App_Start;
using System;
using System.Web.Optimization;
using Umbraco.Web;
using System.Web.Routing;

namespace AirFlow
{
    public class AirFlowApplication : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            AutofacConfig.Configure();
        }
    }
}