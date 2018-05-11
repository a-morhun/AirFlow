using System;
using PetaPoco;

namespace AirFlow.Data.Security.Account
{
    [TableName("airFlowMemberRegistration")]
    public class UserAccountDto
    {
        [Column(name: "nodeId")]
        public int UserId { get; set; }

        [Column(name: "email_confirmed")]
        public bool EmailConfirmed { get; set; }

        [Column(name: "confirmation_token")]
        public string ConfirmationToken { get; set; }

        [Column(name: "confirmation_token_expiration")]
        public DateTime ConfirmationExpirationDate { get; set; }

        [Column(name: "confirmation_date")]
        public DateTime? ConfirmationDate { get; set; }

        [Column(name: "login_type")]
        public byte LoginType { get; set; }

        public override string ToString()
        {
            return $"UserId: {UserId}, " +
                   $"ConfirmationToken: {ConfirmationToken}, " +
                   $"ExpirationDate (UTC): {ConfirmationExpirationDate}," +
                   $"LoginType: {LoginType}";
        }
    }
}