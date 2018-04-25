namespace AirFlow.Data.Security.Auth
{
    public interface ILoginRepository
    {
        void SaveLoginToken(TwoFactorLoginDto dto);

        Token GetLoginTokenDetails(string token);

        string ConfirmLogin(int userId);

        AdditionalLoginInfo GetAdditionalLoginInfo(string email);
    }
}