using AirFlow.Models.Account;

namespace AirFlow.Services.Account
{
    public interface IUserRegistration
    {
        /// <exception cref="MemberServiceException">Thrown when memberService failed to create a new member</exception>
        void Register(UserToRegister user);
    }
}