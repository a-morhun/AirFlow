using System;

namespace AirFlow.Services.Email
{
    public class EmailSenderException : Exception
    {
        public EmailSenderException(string message, Exception innterException) : 
            base(message, innterException)
        {
        }
    }
}