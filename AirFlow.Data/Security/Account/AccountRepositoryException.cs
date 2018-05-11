using System;

namespace AirFlow.Data.Security.Account
{
    public class AccountRepositoryException : Exception
    {
        public AccountRepositoryException(string message, Exception innterException) :
            base(message, innterException)
        {
        }
    }
}