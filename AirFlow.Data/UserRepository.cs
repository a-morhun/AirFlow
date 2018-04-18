using AirFlow.Data.Models;
using PetaPoco;
using System.Linq;

namespace AirFlow.Data
{
    public class UserRepository : IUserRepository
    {
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