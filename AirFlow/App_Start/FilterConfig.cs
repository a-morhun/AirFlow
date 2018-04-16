using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new MemberAuthorizeAttribute());
        }
    }
}