using AirFlow.Data.Models;

namespace AirFlow.Data
{
    public interface IUserRepository
    {
        AdditionalLoginInfo GetAdditionalLoginInfo(string email);
    }
}