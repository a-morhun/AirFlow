using AirFlow.Data.Models;
using PetaPoco;
using System.Linq;

namespace AirFlow.Data
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
    }
}