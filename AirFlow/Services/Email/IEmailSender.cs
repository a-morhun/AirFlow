using System.Net.Mail;

namespace AirFlow.Services.Email
{
    public interface IEmailSender
    {
        void Send(MailMessage message);
    }
}