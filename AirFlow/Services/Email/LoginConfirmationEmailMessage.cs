namespace AirFlow.Services.Email
{
    internal class LoginConfirmationEmailMessage : ConfirmationEmailMessage
    {
        public LoginConfirmationEmailMessage(string bodyTemplate, ConfirmationEmailMessageOptions options)
            : base("AirFlow login confirmation", "ConfirmLogin", bodyTemplate, options)
        {
        }
    }
}