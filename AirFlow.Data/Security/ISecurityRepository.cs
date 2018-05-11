using AirFlow.Data.Security.Account;
using AirFlow.Data.Security.Auth;

namespace AirFlow.Data.Security
{
    /// <exception cref="AccountRepositoryException">Thrown when account repository failed to maintaint data</exception>
    /// <exception cref="LoginRepositoryException">Thrown when account repository failed to maintaint data</exception>
    public interface ISecurityRepository : IAccountRepository, ILoginRepository
    {
    }
}