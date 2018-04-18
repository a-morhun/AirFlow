using AirFlow.Data.Models;

namespace AirFlow.Data
{
    public interface IUserSecurityRepository
    {
        void Save(UserRegistrationDto dto);

        ConfirmationToken GetConfirmationTokenDetails(string confirmationToken);

        void ConfirmEmail(int userId);

        bool IsEmailConfirmed(string email);
    }
}