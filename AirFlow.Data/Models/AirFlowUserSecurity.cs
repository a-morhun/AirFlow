using System;
using PetaPoco;

namespace AirFlow.Data.Models
{
    [TableName("AirFlowMemberSecurity")]
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

        [Column(name: "login_type")]
        public int LoginType { get; set; }

        [Column(name: "login_token")]
        public string LoginToken { get; set; }

        [Column(name: "login_token_expiration")]
        public DateTime? LoginTokenExpirationDate { get; set; }
    }
}