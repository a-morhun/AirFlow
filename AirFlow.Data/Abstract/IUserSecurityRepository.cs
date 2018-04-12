using System;
using AirFlow.Data.Models;

namespace AirFlow.Data.Abstract
{
    public interface IUserSecurityRepository
    {
        void Save(AirFlowUserSecurity dto);

        (int userId, DateTime expirationDate)? GetByConfirmationToken(string confirmationToken);

        void ConfirmEmail(AirFlowUserSecurity dto);
    }
}