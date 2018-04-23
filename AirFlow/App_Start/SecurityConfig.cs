using AirFlow.Models.Account;
using AirFlow.ServiceContainers;
using Autofac;
using System;
using System.Collections.Generic;
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow
{
    public class SecurityConfig
    {
        public static void Initialize()
        {
            CreateInitialMemberGroups();
            CreateInitialPublicAccess();
        }

        #region Initial member groups

        private static void CreateInitialMemberGroups()
        {
            var memberGroupService = AirFlowServiceContainer.Container.Resolve<IMemberGroupService>();
            foreach (IMemberGroup userRole in GetUserRoles())
            {
                if (memberGroupService.GetByName(userRole.Name) == null)
                {
                    memberGroupService.Save(userRole);
                }
            }
        }

        private static IEnumerable<IMemberGroup> GetUserRoles()
        {
            foreach (var userRole in Enum.GetValues(typeof(UserRoleType)))
            {
                yield return new MemberGroup
                {
                    Name = userRole.ToString()
                };
            }
        }

        #endregion

        #region Initial public access

        private static void CreateInitialPublicAccess()
        {
            SetPublicAccessToHomePage();
        }

        private static void SetPublicAccessToHomePage()
        {
            var contentService = AirFlowServiceContainer.Container.Resolve<IContentService>();
            var publicAccessService = AirFlowServiceContainer.Container.Resolve<IPublicAccessService>();

            IContent homeNode = contentService.GetById(1072);
            IContent loginNode = contentService.GetById(1073);
            IContent errorNode = contentService.GetById(1079);

            if (publicAccessService.IsProtected(homeNode))
            {
                return;
            }

            var entry = new PublicAccessEntry(homeNode, loginNode, errorNode, new List<PublicAccessRule>());

            publicAccessService.Save(entry);
            publicAccessService.AddRule(homeNode, Constants.Conventions.PublicAccess.MemberRoleRuleType, UserRoleType.Regular.ToString());
        }

        #endregion
    }
}