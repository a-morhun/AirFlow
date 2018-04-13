using Umbraco.Core.Models;

namespace AirFlow.Models.Account
{
    public interface IUserRegistration
    {
        IMember Register(UserToRegister user);
    }
}