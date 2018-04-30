namespace AirFlow.Data.Security.Auth
{
    /// <exception cref="LoginRepositoryException">Thrown when account repository failed to insert new data</exception>
    public interface ILoginRepository
    {
        void SaveLoginToken(TwoFactorLoginDto dto);

        Token GetLoginTokenDetails(string token);

        string ConfirmLogin(int userId);

        AdditionalLoginInfo GetAdditionalLoginInfo(string email);
    }
}