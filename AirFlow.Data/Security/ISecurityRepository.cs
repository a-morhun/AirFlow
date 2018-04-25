using AirFlow.Data.Security.Account;
using AirFlow.Data.Security.Auth;

namespace AirFlow.Data.Security
{
    public interface ISecurityRepository : IAccountRepository, ILoginRepository
    {
    }
}