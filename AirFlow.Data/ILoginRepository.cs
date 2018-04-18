using AirFlow.Data.Models;

namespace AirFlow.Data
{
    public interface ILoginRepository
    {
        void SaveLoginToken(TwoFactorLoginDto dto);

        Token GetLoginTokenDetails(string token);

        string ConfirmLogin(int userId);
    }
}