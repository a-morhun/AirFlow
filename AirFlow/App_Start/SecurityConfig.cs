using AirFlow.Models.Account;
using AirFlow.Services.Containers;
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
            var memberGroupService = AirFlowServiceContainer.Instance.GetInstance<IMemberGroupService>();
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
            var contentService = AirFlowServiceContainer.Instance.GetInstance<IContentService>();

            IContent GetNodeByAlias(string alias)
            {
                IPublishedContent homeContent = umbracoHelper.TypedContentSingleAtXPath("//" + alias);
                return contentService.GetById(homeContent.Id);
            }

            IContent homeNode = GetNodeByAlias("home");
            var publicAccessService = AirFlowServiceContainer.Instance.GetInstance<IPublicAccessService>();

            if (publicAccessService.IsProtected(homeNode))
            {
                return;
            }

            IContent loginNode = GetNodeByAlias("login");
            IContent errorNode = GetNodeByAlias("error");

            var entry = new PublicAccessEntry(homeNode, loginNode, errorNode, new List<PublicAccessRule>());

            publicAccessService.Save(entry);
            publicAccessService.AddRule(homeNode, Constants.Conventions.PublicAccess.MemberRoleRuleType, UserRoleType.Regular.ToString());
        }

        #endregion
    }
}