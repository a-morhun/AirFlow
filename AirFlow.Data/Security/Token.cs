using System;

namespace AirFlow.Data.Security
{
    public class Token
    {
        public int ForUserId { get; set; }

        public DateTime ExpirationDate { get; set; }

        public bool IsExpired => DateTime.UtcNow >= ExpirationDate;

        public override string ToString()
        {
            return $"UserId: {ForUserId}, ExpirationDate: {ExpirationDate}, IsExpired: {IsExpired}";
        }
    }
}