using AirFlow.Models.Common;

namespace AirFlow.Services.Auth
{
    public interface IAuthService
    {
        Result ConfirmEmail(string token);
    }
}