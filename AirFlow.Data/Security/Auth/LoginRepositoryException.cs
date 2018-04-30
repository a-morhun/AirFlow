using System;

namespace AirFlow.Data.Security.Auth
{
    public class LoginRepositoryException : Exception
    {
        public LoginRepositoryException(string message, Exception innterException) :
            base(message, innterException)
        {
        }
    }
}