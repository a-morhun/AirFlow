namespace AirFlow.Services.Abstract
{
    public interface IMembership
    {
        string GetUserNameByEmail(string email);

        bool ValidateUser(string username, string password);
    }
}
