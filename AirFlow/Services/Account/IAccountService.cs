using AirFlow.Models.Account;
using AirFlow.Models.Common;

namespace AirFlow.Services.Account
{
    public interface IAccountService
    {
        Result Register(UserToRegister user);
    }
}
