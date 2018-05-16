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
                try
                {
                    db.Insert(user);
                }
                catch (Exception e)
                {
                    throw new AccountRepositoryException($"Failed to save info for userId '{user.UserId}'", e);
                }
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

                try
                {
                    return db.Fetch<ConfirmationToken>(sql).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new AccountRepositoryException("Failed to retreive token details", e);
                }
            }
        }

        public void ConfirmEmail(int userId)
        {
            var (emailConfirmed, confirmationDate) = (true, DateTime.UtcNow);
            const string query = "UPDATE airFlowMemberRegistration SET email_confirmed = @0, confirmation_date = @1 WHERE nodeId = @2;";

            using (var db = new Database(Config.ConnectionStringName))
            {
                try
                {
                    db.Execute(query, emailConfirmed, confirmationDate, userId);
                }
                catch (Exception e)
                {
                    throw new AccountRepositoryException("Failed to confirm email", e);
                }
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

                try
                {
                    return db.Fetch<bool>(sql).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new AccountRepositoryException("Failed to retreive confirmation info", e);
                }
            }
        }

        public bool IsRegistrationInfoSaved(int userId)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("1")
                    .From("airFlowMemberRegistration")
                    .Where("nodeId = @0", userId);

                try
                {
                    return db.Fetch<bool>(sql).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new AccountRepositoryException("Failed to check if user has a registration info", e);
                }
            }
        }
    }
}