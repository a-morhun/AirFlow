﻿using AirFlow.Data;
using AirFlow.Services.Account;
using AirFlow.Services.Auth;
using AirFlow.Services.Email;
using Autofac.Integration.Mvc;
using Autofac.Integration.WebApi;
using Autofac;
using System.Web.Http;
using System.Web.Mvc;
using AirFlow.Services.Containers;
using AirFlow.Services.Helpers;
using Umbraco.Core;
using Umbraco.Core.Services;
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

            builder.RegisterInstance(AirFlowHelper.Instance).As<IAirFlowHelper>();
            builder.RegisterInstance(AirFlowServiceContainer.Instance).As<IServiceContainer>();

            builder.Register((c, p) => new EmailTypeLoginProvider(
                    p.Named<string>("userEmail"),
                    c.Resolve<ILoginRepository>(),
                    c.Resolve<ITokenGenerator>(),
                    c.Resolve<IEmailSender>()))
                .As<ITwoFactorLoginProvider>();
        }

        private static void RegisterUmbracoServices(ContainerBuilder builder)
        {
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberService).As<IMemberService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberTypeService).As<IMemberTypeService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.MemberGroupService).As<IMemberGroupService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.ContentService).As<IContentService>();
            builder.RegisterInstance(ApplicationContext.Current.Services.PublicAccessService).As<IPublicAccessService>();
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