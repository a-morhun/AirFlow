using System;

namespace AirFlow.Data.Models
{
    public class ConfirmationToken
    {
        public int UserId { get; set; }

        public DateTime ExpirationDate { get; set; }

        public bool AlreadyConfirmed { get; set; }
    }
}