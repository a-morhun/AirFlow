namespace AirFlow.Services.Auth
{
    public interface ITwoFactorLoginProcessor
    {
        void Process(int userId);
    }
}