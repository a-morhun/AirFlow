using System;

namespace AirFlow.Data.Models
{
    public class Token
    {
        public int ForUserId { get; set; }

        public DateTime ExpirationDate { get; set; }

        public bool IsExpired => DateTime.UtcNow >= ExpirationDate;
    }
}