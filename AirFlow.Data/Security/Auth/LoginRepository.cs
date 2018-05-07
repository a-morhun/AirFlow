using System;
using PetaPoco;
using System.Linq;

namespace AirFlow.Data.Security.Auth
{
    public class LoginRepository : ILoginRepository
    {
        public void SaveLoginToken(TwoFactorLoginDto dto)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                try
                {
                    db.Execute("DELETE FROM airFlowTwoFactorLogin WHERE nodeId = @0", dto.UserId);
                    db.Insert(dto);
                }
                catch (Exception e)
                {
                    throw new LoginRepositoryException("Failed to save login token", e);
                }
            }
        }

        public Token GetLoginTokenDetails(string token)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("nodeId AS ForUserId, " +
                            "token_expiration AS ExpirationDate")
                    .From("airFlowTwoFactorLogin")
                    .Where("token = @0", token);

                try
                {
                    return db.Fetch<Token>(sql).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new LoginRepositoryException("Failed to retreive login details", e);
                }
            }
        }

        public string ConfirmLogin(int userId)
        {
            const string updateQuery = "DELETE FROM airFlowTwoFactorLogin WHERE nodeId = @0";
            const string getUsername = "SELECT LoginName FROM cmsMember WHERE nodeId = @0";

            using (var db = new Database(Config.ConnectionStringName))
            {
                try
                {
                    db.Execute(updateQuery, userId);
                    return db.Fetch<string>(getUsername, userId).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new LoginRepositoryException("Failed to confirm login", e);
                }
            }
        }

        public AdditionalLoginInfo GetAdditionalLoginInfo(string email)
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                var sql = Sql.Builder
                    .Select("M.nodeId AS UserId, " +
                            "M.LoginName AS Username, " +
                            "A.login_type AS LoginType")
                    .From("cmsMember AS M")
                    .InnerJoin("airFlowMemberRegistration AS A").On("M.nodeId = A.nodeId")
                    .Where("M.email = @0", email);

                try
                {
                    return db.Fetch<AdditionalLoginInfo>(sql).FirstOrDefault();
                }
                catch (Exception e)
                {
                    throw new LoginRepositoryException("Failed to retreive additional login info", e);
                }
            }
        }
    }
}