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
                db.Execute("DELETE FROM airFlowTwoFactorLogin WHERE nodeId = @0", dto.UserId);
                db.Insert(dto);
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
                return db.Fetch<Token>(sql).FirstOrDefault();
            }
        }

        public string ConfirmLogin(int userId)
        {
            const string updateQuery = "UPDATE airFlowTwoFactorLogin SET token = null, token_expiration = null WHERE nodeId = @0";
            const string getUsername = "SELECT LoginName FROM cmsMember WHERE nodeId = @0";

            using (var db = new Database(Config.ConnectionStringName))
            {
                db.Execute(updateQuery, userId);
                return db.Fetch<string>(getUsername, userId).FirstOrDefault();
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

                return db.Fetch<AdditionalLoginInfo>(sql).FirstOrDefault();
            }
        }
    }
}