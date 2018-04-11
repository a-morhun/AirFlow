using System.ComponentModel.DataAnnotations;

namespace AirFlow.Models.Auth
{
    public class UserRegistrationViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Username { get; set; }

        [Required]
        public string Password { get; set; }
    }
}