using System.ComponentModel.DataAnnotations;
using AirFlow.Models.Auth;

namespace AirFlow.Models.Account
{
    public class UserRegistrationViewModel
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Username { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]        
        [MinLength(10)]
        public string Password { get; set; }

        [Display(Name = "Login type")]
        public LoginType LoginType { get; set; }

        [Required]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        public override string ToString()
        {
            return $"Email: {Email}, Username: {Username}, Name:{Name}, LoginType: {LoginType}";
        }
    }
}