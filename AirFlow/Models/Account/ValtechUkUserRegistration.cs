using AirFlow.Data;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public class ValtechUkUserRegistration : UserRegistration
    {
        public ValtechUkUserRegistration(IMemberService memberService, IMemberTypeService memberTypeService, IUserSecurityRepository securityRepository)
            : base(memberService, memberTypeService, securityRepository)
        {
        }

        protected override void SetMemberApproval(IMember member)
        {
            member.IsApproved = true;
        }
    }
}