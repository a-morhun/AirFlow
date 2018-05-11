using System.Web.Security;

namespace AirFlow.Services.Auth
{
    internal class MembershipWrapper : IMembership
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