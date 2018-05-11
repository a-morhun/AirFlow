using System.Web.Mvc;
using System.Web.Routing;

namespace AirFlow
{
    internal class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapMvcAttributeRoutes();
        }
    }
}