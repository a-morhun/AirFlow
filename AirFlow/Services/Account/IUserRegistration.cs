using AirFlow.Models.Account;

namespace AirFlow.Services.Account
{
    public interface IUserRegistration
    {
        void Register(UserToRegister user);
    }
}