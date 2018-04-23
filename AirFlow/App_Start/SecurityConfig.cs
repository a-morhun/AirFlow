using AirFlow.Models.Account;
using AirFlow.ServiceContainers;
using Autofac;
using System;
using System.Collections.Generic;
using Umbraco.Core;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Web;

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
            var umbracoHelper = new UmbracoHelper(UmbracoContext.Current);
            IPublishedContent homeContent = umbracoHelper.TypedContentSingleAtXPath("//home");

            if (homeContent == null)
            {
                return;
            }

            var contentService = AirFlowServiceContainer.Container.Resolve<IContentService>();
            IContent homeNode = contentService.GetById(homeContent.Id);
            var publicAccessService = AirFlowServiceContainer.Container.Resolve<IPublicAccessService>();

            if (publicAccessService.IsProtected(homeNode))
            {
                return;
            }

            IPublishedContent loginContent = umbracoHelper.TypedContentSingleAtXPath("//" + "login");
            IPublishedContent errorContent = umbracoHelper.TypedContentSingleAtXPath("//" + "error");

            if (loginContent == null || errorContent == null)
            {
                return;
            }

            var entry = new PublicAccessEntry(new Guid(), homeContent.Id, loginContent.Id, errorContent.Id, new List<PublicAccessRule>());

            publicAccessService.Save(entry);
            publicAccessService.AddRule(homeNode, Constants.Conventions.PublicAccess.MemberRoleRuleType, UserRoleType.Regular.ToString());
        }

        #endregion
    }
}