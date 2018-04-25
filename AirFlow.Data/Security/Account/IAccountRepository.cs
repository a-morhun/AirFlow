namespace AirFlow.Data.Security.Account
{
    public interface IAccountRepository
    {
        void Save(UserAccountDto user);

        ConfirmationToken GetConfirmationTokenDetails(string confirmationToken);

        void ConfirmEmail(int userId);

        bool IsEmailConfirmed(string email);
    }
}