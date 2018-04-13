using AirFlow.Models.Common;

namespace AirFlow.Models.Auth
{
    public class LoginResult : Result
    {
        public string Username { get; }

        public LoginResult(string username)
        {
            Username = username;
        }

        public LoginResult(ErrorCodeType errorCode, string errorMessage = "") : base(errorCode, errorMessage)
        {
        }
    }
}