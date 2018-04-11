namespace AirFlow.Services.Abstract
{
    public interface IFormsAuthentication
    {
        void SetAuthCookie(string username, bool createPersistentCookie);

        void SignOut();
    }
}