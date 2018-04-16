using AirFlow.Models.Account;

namespace AirFlow.Models.Auth
{
    public class UserToLogin : User
    {
        public string Password { get; set; }

        public UserToLogin(UserLoginViewModel loginRequest)
        {
            Email = loginRequest.Email;
            Password = loginRequest.Password;
        }
    }
}