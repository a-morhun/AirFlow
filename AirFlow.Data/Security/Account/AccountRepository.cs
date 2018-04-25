using PetaPoco;
using System;
using System.Linq;

namespace AirFlow.Data.Security.Account
{
    public class AccountRepository : IAccountRepository
    {
        public void Save(UserAccountDto user)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                db.Insert(user);
            }
        }

        public ConfirmationToken GetConfirmationTokenDetails(string confirmationToken)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("nodeId AS ForUserId, " +
                            "confirmation_token_expiration AS ExpirationDate," +
                            "email_confirmed AS AlreadyConfirmed")
                    .From("airFlowMemberRegistration")
                    .Where("confirmation_token = @0", confirmationToken);
                return db.Fetch<ConfirmationToken>(sql).FirstOrDefault();
            }
        }

        public void ConfirmEmail(int userId)
        {
            var dto = (UserId: userId, EmailConfirmed: true, ConfirmationDate: DateTime.UtcNow);
            const string query = "UPDATE airFlowMemberRegistration SET email_confirmed = @0, confirmation_date = @1 WHERE nodeId = @2;";

            using (var db = new Database(Config.ConnectionStringName))
            {
                db.Execute(query, dto.EmailConfirmed, dto.ConfirmationDate, dto.UserId);
            }
        }

        public bool IsEmailConfirmed(string email)
        {
            using (var db = new Database(Config.ConnectionStringName))
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