using AirFlow.Models.Common;

namespace AirFlow.Models.Auth
{
    public class RegistrationResult : Result
    {
        public bool ShouldAutoLogin { get; }

        public RegistrationResult(bool shouldAutoLogin) : base()
        {
            ShouldAutoLogin = shouldAutoLogin;
        }
    }
}