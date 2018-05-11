namespace AirFlow.Services.Email
{
    internal class EmailConfirmationEmailMessage : ConfirmationEmailMessage
    {
        public EmailConfirmationEmailMessage(string bodyTemplate, ConfirmationEmailMessageOptions options)
            : base("AirFlow registration", "ConfirmEmail", bodyTemplate, options)
        {
        }
    }
}