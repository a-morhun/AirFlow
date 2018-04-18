using AirFlow.Data;
using AirFlow.Services.Account;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using Autofac.Integration.Mvc;
using Autofac.Integration.WebApi;
using Autofac;
using System.Web.Http;
using System.Web.Mvc;
using AirFlow.ServiceContainers;
using Umbraco.Core;
using Umbraco.Core.Services;
using Umbraco.Forms.Web.Trees;
using Umbraco.Web;
using IEmailSender = AirFlow.Services.Email.IEmailSender;

namespace AirFlow
{
    public class AutofacConfig
    {
        public static void Configure()
        {
            var builder = new ContainerBuilder();

            RegisterUmbracoBackOffice(builder);
            RegisterAirFlowControllers(builder);
            RegisterAirFlowServices(builder);
            RegisterUmbracoServices(builder);
            SetResolvers(builder);
        }

        private static void RegisterUmbracoBackOffice(ContainerBuilder builder)
        {
            var umbracoAssembly = typeof(UmbracoApplication).Assembly;
            builder.Register(c => UmbracoContext.Current).AsSelf();
            builder.RegisterControllers(umbracoAssembly);
            builder.RegisterApiControllers(umbracoAssembly);

            var umbracoFormsAssembly = typeof(DataSourceTreeController).Assembly;
            builder.RegisterControllers(umbracoFormsAssembly);
            builder.RegisterApiControllers(umbracoFormsAssembly);
        }

        private static void RegisterAirFlowControllers(ContainerBuilder builder)
        {
            var currentAssembly = typeof(AirFlowApplication).Assembly;
            builder.RegisterControllers(currentAssembly);
            builder.RegisterApiControllers(currentAssembly);
        }

        private static void RegisterAirFlowServices(ContainerBuilder builder)
        {
            builder.RegisterType<AccountService>().As<IAccountService>();
            builder.RegisterType<AuthService>().As<IAuthService>();
            builder.RegisterType<FormsAuthenticationWrapper>().As<IFormsAuthentication>();
            builder.RegisterType<MembershipWrapper>().As<IMembership>();
            builder.RegisterType<TokenGenerator>().As<ITokenGenerator>();
            builder.RegisterType<SmtpEmailSender>().As<IEmailSender>();

            builder.RegisterType<UserSecurityRepository>().As<IUserSecurityRepository>();
            builder.RegisterType<UserRegistration>().As<IUserRegistration>();
            builder.RegisterType<UserRepository>().As<IUserRepository>();
            builder.RegisterType<LoginRepository>().As<ILoginRepository>();
            builder.RegisterType<AuthRepository>().As<IAuthRepository>();

            builder.Register((c, p) => new EmailTypeLoginProcessor(
                    p.Named<string>("userEmail"),
                    c.Resolve<ILoginRepository>(),
                    c.Resolve<ITokenGenerator>(),
                    c.Resolve<IEmailSender>()))
                .As<ITwoFactorLoginProcessor>();
        }

        private static void RegisterUmbracoServices(ContainerBuilder builder)
        {
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberService).As<IMemberService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberTypeService).As<IMemberTypeService>();
        }

        private static void SetResolvers(ContainerBuilder builder)
        {
            IContainer container = builder.Build();
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
            GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container);

            AirFlowServiceContainer.SetContainer(container);
        }
    }
}