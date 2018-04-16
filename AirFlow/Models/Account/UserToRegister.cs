using AirFlow.Models.Auth;

namespace AirFlow.Models.Account
{
    public class UserToRegister : User
    {
        public string Password { get; set; }

        public UserToRegister(UserRegistrationViewModel registrationRequest)
        {
            Username = registrationRequest.Username;
            Password = registrationRequest.Password;
            Email = registrationRequest.Email;
            Name = registrationRequest.Name;
        }
    }
}