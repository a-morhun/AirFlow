using System.ComponentModel.DataAnnotations;

namespace AirFlow.Models.Auth
{
    public class UserLoginViewModel
    {
        [Required]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }

        public override string ToString()
        {
            return $"Email: {Email}";
        }
    }
}