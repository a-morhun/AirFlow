using AirFlow.Models.Auth;
using AirFlow.Models.Common;

namespace AirFlow.Services.Auth
{
    public interface IAuthService
    {
        LoginResult Login(UserToLogin user);

        Result ConfirmEmail(string token);
    }
}