namespace AirFlow.Services.Auth
{
    public interface IMembership
    {
        string GetUserNameByEmail(string email);

        bool ValidateUser(string username, string password);
    }
}
