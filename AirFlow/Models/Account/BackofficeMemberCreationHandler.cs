using AirFlow.Data.Security.Account;
using AirFlow.Services.Account;
using AirFlow.Services.Containers;
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Events;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public class BackofficeMemberCreationHandler : ApplicationEventHandler
    {
        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            // This event is raised multiple times: http://issues.umbraco.org/issue/U4-7085
            MemberService.Saved += MemberSavedHandler;
        }

        protected void MemberSavedHandler(IMemberService sender, SaveEventArgs<IMember> args)
        {
            var accountRepository = AirFlowServiceContainer.Instance.GetInstance<IAccountRepository>();
            IMember savedMember = args.SavedEntities.Single();

            if (accountRepository.IsRegistrationInfoSaved(savedMember.Id))
            {
                return;
            }

            var userRegistrator = AirFlowServiceContainer.Instance.GetInstance<IUserRegistration>();
            userRegistrator.CompleteRegistrationFromBackoffice(savedMember);
        }
    }
}