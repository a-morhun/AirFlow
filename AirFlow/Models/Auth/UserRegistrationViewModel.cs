using System.ComponentModel.DataAnnotations;

namespace AirFlow.Models.Auth
{
    public class UserRegistrationViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Password { get; set; }
    }
}