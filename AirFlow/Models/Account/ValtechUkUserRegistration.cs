using AirFlow.Data.Abstract;
using AirFlow.Data.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public class ValtechUkUserRegistration : UserRegistration
    {
        public ValtechUkUserRegistration(IMemberService memberService, IMemberTypeService memberTypeService, IUserSecurityRepository securityRepository)
            : base(memberService, memberTypeService, securityRepository)
        {
        }

        protected override void SaveSecurityInfo(int userId, out string token)
        {
            token = null;
            var airflowMember = new AirFlowUserSecurity()
            {
                UserId = userId,
            };

            Repository.Save(airflowMember);
        }
    }
}