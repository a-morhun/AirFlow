using AirFlow.Data;
using Umbraco.Core.Models;
using Umbraco.Core.Services;

namespace AirFlow.Models.Account
{
    public abstract class UserRegistration : IUserRegistration
    {
        private const string DefaultMemberType = "Member";
        private const string RegularMemberGroup = "Regular";

        protected readonly IMemberService MemberService;
        protected readonly IMemberTypeService MemberTypeService;
        protected readonly IUserSecurityRepository Repository;

        protected UserRegistration(
            IMemberService memberService,
            IMemberTypeService memberTypeService,
            IUserSecurityRepository securityRepository)
        {
            MemberService = memberService;
            MemberTypeService = memberTypeService;
            Repository = securityRepository;
        }

        public virtual IMember Register(UserToRegister user)
        {
            IMember registeredUser = MemberService.CreateMemberWithIdentity(user.Username, user.Email, user.Name, DetermineMemberType().Alias);
            SetMemberApproval(registeredUser);
            MemberService.SavePassword(registeredUser, user.Password);
            MemberService.Save(registeredUser);
            MemberService.AssignRole(registeredUser.Id, RegularMemberGroup);

            return registeredUser;
        }

        protected abstract void SetMemberApproval(IMember member);

        private IMemberType DetermineMemberType()
        {
            return MemberTypeService.Get(DefaultMemberType);
        }
    }
}