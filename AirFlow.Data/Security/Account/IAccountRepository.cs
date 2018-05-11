namespace AirFlow.Data.Security.Account
{
    /// <exception cref="AccountRepositoryException">Thrown when account repository failed to insert new data</exception>
    public interface IAccountRepository
    {
        void Save(UserAccountDto user);

        ConfirmationToken GetConfirmationTokenDetails(string confirmationToken);

        void ConfirmEmail(int userId);

        bool IsEmailConfirmed(string email);
    }
}