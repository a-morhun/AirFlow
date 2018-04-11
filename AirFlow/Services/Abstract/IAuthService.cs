using AirFlow.Models.Auth;
using AirFlow.Models.Common;

namespace AirFlow.Services.Abstract
{
    public interface IAuthService
    {
        Result Register(UserRegistrationViewModel user);
    }
}
