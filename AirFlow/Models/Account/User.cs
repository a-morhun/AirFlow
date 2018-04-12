namespace AirFlow.Models.Account
{
    public class User
    {
        private const string ValtechUkDomain = "@valtech.co.uk";

        public string Username { get; set; }

        public string Name { get; set; }

        public string Email { get; set; }

        public UserType Type => DetermineType();

        public bool IsEmailConfirmed { get; set; }

        private UserType DetermineType()
        {
            return IsValtechUkUser(Email) ? UserType.ValtechUk : UserType.Regular;
        }

        private bool IsValtechUkUser(string email) => email.Contains(ValtechUkDomain);
    }
}