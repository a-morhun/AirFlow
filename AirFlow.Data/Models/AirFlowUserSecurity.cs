using System;
using PetaPoco;

namespace AirFlow.Data.Models
{
    [TableName("airFlowMemberRegistration")]
    public class AirFlowUserSecurity
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
    }
}