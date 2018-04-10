using System.ComponentModel.DataAnnotations;

namespace AirFlow.Models.Auth
{
    public class UserLoginViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}