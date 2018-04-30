using AirFlow.Models.Common;

namespace AirFlow.Models.Auth
{
    public class LoginResult : Result
    {
        public string Username { get; }

        public LoginType Type { get; }

        public LoginResult(string username)
        {
            Username = username;
        }

        public LoginResult(string username, LoginType type) : this(username)
        {
            Type = type;
        }

        public LoginResult(ErrorCodeType errorCode, string errorMessage = "") : base(errorCode, errorMessage)
        {
        }

        public override string ToString()
        {
            return $"{base.ToString()}, Username: {Username}";
        }
    }
}