using AirFlow.Models.Account;
using Umbraco.Core.Models;

namespace AirFlow.Services.Account
{
    public interface IUserRegistration
    {
        IMember Register(UserToRegister user);
    }
}