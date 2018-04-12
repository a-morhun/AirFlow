namespace AirFlow.Services.Auth
{
    public interface IFormsAuthentication
    {
        void SetAuthCookie(string username, bool createPersistentCookie);

        void SignOut();
    }
}