using AirFlow.Data.Models;

namespace AirFlow.Data
{
    public interface IUserSecurityRepository
    {
        void Save(AirFlowUserSecurity dto);

        ConfirmationToken GetByConfirmationToken(string confirmationToken);

        void ConfirmEmail(int userId);

        bool IsEmailConfirmed(string email);
    }
}