using System;
using System.Linq;
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

        public ConfirmationToken GetByConfirmationToken(string confirmationToken)
        {
            using (var db = new Database(ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("nodeId AS UserId, " +
                            "confirmation_token_expiration AS ExpirationDate," +
                            "email_confirmed AS AlreadyConfirmed")
                    .From("airFlowMemberRegistration")
                    .Where("confirmation_token = @0", confirmationToken);
                return db.Fetch<ConfirmationToken>(sql).FirstOrDefault();
            }
        }

        public void ConfirmEmail(int userId)
        {
            var dto = new AirFlowUserSecurity
            {
                UserId = userId,
                EmailConfirmed = true,
                ConfirmationDate = DateTime.UtcNow
            };

            using (var db = new Database(ConnectionStringName))
            {
                db.Execute("UPDATE airFlowMemberRegistration SET email_confirmed = @0, confirmation_date = @1 WHERE nodeId = @2;", true, DateTime.UtcNow, userId);
            }
        }

        public bool IsEmailConfirmed(string email)
        {
            using (var db = new Database(ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("A.email_confirmed")
                    .From("airFlowMemberRegistration as A")
                    .InnerJoin("cmsMember AS M").On("M.nodeId = A.nodeId")
                    .Where("M.email = @0", email);

                return db.Fetch<bool>(sql).FirstOrDefault();
            }
        }
    }
}