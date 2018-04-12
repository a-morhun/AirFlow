using System;
using System.Linq;
using AirFlow.Data.Abstract;
using AirFlow.Data.Models;
using PetaPoco;

namespace AirFlow.Data
{
    public class UserSecurityRepository : IUserSecurityRepository
    {
        public const string ConnectionStringName = "umbracoDbDSN";

        public void Save(AirFlowUserSecurity dto)
        {
            using (var db = new Database(ConnectionStringName))
            {
                db.Insert(dto);
            }
        }

        public (int userId, DateTime expirationDate)? GetByConfirmationToken(string confirmationToken)
        {
            using (var db = new Database(ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("nodeId, confirmation_token_expiration")
                    .Where("confirmation_token = @confirmationToken");
                return db.Fetch<(int, DateTime)>(sql).FirstOrDefault();
            }
        }

        public void ConfirmEmail(AirFlowUserSecurity dto)
        {
            using (var db = new Database(ConnectionStringName))
            {
                db.Update(dto, new [] { "email_confirmed" });
            }
        }
    }
}