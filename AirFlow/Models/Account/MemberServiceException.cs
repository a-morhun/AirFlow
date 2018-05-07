using System;

namespace AirFlow.Models.Account
{
    public class MemberServiceException : Exception
    {
        public MemberServiceException(string message, Exception innterException) :
            base(message, innterException)
        {
        }
    }
}