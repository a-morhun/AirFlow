using System.Web.Security;

namespace AirFlow.Services.Auth
{
    internal class FormsAuthenticationWrapper : IFormsAuthentication
    {
        public void SetAuthCookie(string username, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(username, createPersistentCookie);
        }

        public void SignOut()
        {
            FormsAuthentication.SignOut();
        }
    }
}