namespace AirFlow.Services.Auth
{
    public interface ITwoFactorLoginProvider
    {
        void Process(int userId);
    }
}