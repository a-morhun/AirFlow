namespace AirFlow.Services.Email
{
    public interface IEmailSender
    {
        /// <exception cref="EmailSenderException">Thrown when client failed to send an email</exception>
        void Send(EmailMessageType type, EmailMessageOptions options);
    }
}