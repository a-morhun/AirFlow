using AirFlow.Models.Auth;
using AirFlow.Models.Common;
using AirFlow.Services.Abstract;
using System;
using Umbraco.Core.Services;
using Umbraco.Core.Models;

namespace AirFlow.Services
{
    public class AuthService : IAuthService
    {
        private readonly IMemberService _memberService;
        private readonly IMemberTypeService _memberTypeService;

        private const string ValtechUkDomain = "@valtech.co.uk";
        private const string DefaultMemberType = "Member";
        private const string RegularMemberGroup = "Regular";

        public AuthService(IMemberService memberService, IMemberTypeService memberTypeService)
        {
            _memberService = memberService;
            _memberTypeService = memberTypeService;
        }

        public Result Register(UserRegistrationViewModel user)
        {
            bool isValtechUkUser = IsValtechUkUser(user.Email);

            if (_memberService.Exists(user.Username) || _memberService.GetByEmail(user.Email) != null)
            {
                return new Result(ErrorCodeType.MemberAlreadyExists, "Already exists");
            }

            try
            {
                IMember member = CreateMember(user.Username, user.Password, user.Email, isValtechUkUser);
                return new RegistrationResult(shouldAutoLogin: member.IsApproved);
            }
            catch (Exception e)
            {
                return new Result(ErrorCodeType.UnknownError, e.Message);
            }
        }

        private bool IsValtechUkUser(string email) => email.Contains(ValtechUkDomain);

        private IMember CreateMember(string username, string password, string email, bool isValtechUkUser)
        {
            IMember member = _memberService.CreateMemberWithIdentity(username, email, username, DetermineMemberType().Alias);
            member.IsApproved = isValtechUkUser;
            _memberService.SavePassword(member, password);
            _memberService.Save(member);

            _memberService.AssignRole(member.Id, RegularMemberGroup);

            return member;
        }

        private IMemberType DetermineMemberType()
        {
            return _memberTypeService.Get(DefaultMemberType);
        }
    }
}