using AirFlow.Services.Abstract;
using System.Web.Security;

namespace AirFlow.Services
{
    public class MembershipWrapper : IMembership
    {
        public string GetUserNameByEmail(string email)
        {
            return Membership.GetUserNameByEmail(email);
        }

        public bool ValidateUser(string username, string password)
        {
            return Membership.ValidateUser(username, password);
        }
    }
}