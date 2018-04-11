using AirFlow.App_Start;
using AirFlow.Services;
using AirFlow.Services.Abstract;
using Autofac;
using Autofac.Integration.Mvc;
using Autofac.Integration.WebApi;
using System;
using System.Reflection;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using Umbraco.Core;
using Umbraco.Core.Services;
using Umbraco.Web;

namespace AirFlow
{
    public class AirFlowApplication : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            //FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            //InitializaIoc();
        }

        // TODO: YSOD error is shown
        private void InitializaIoc()
        {
            var builder = new ContainerBuilder();

            builder.Register(c => UmbracoContext.Current).AsSelf();
            builder.Register(c => ApplicationContext.Current).AsSelf();
            builder.RegisterControllers(Assembly.GetExecutingAssembly());
            builder.RegisterApiControllers(typeof(UmbracoApplication).Assembly);
            builder.RegisterApiControllers(Assembly.GetExecutingAssembly());

            builder.RegisterType<AuthService>().As<IAuthService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberService).As<IMemberService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberTypeService).As<IMemberTypeService>();
           

            var container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
            GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container);
        }
    }
}