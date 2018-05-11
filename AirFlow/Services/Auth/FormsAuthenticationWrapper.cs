using AirFlow.Utilities;
using System;
using System.Web.Security;

namespace AirFlow.Services.Auth
{
    internal class FormsAuthenticationWrapper : IFormsAuthentication
    {
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(FormsAuthenticationWrapper));

        public void SetAuthCookie(string username, bool createPersistentCookie)
        {
            FormsAuthentication.SetAuthCookie(username, createPersistentCookie);
        }

        public void SignOut()
        {
            try
            {
                FormsAuthentication.SignOut();
            }
            catch (Exception e)
            {
                _logger.Error("Failed to sign out", e);
            }
        }
    }
}