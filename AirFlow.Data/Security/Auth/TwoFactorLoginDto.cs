using System;
using PetaPoco;

namespace AirFlow.Data.Security.Auth
{
    [TableName("airFlowTwoFactorLogin")]
    public class TwoFactorLoginDto
    {
        [Column(name: "nodeId")]
        public int UserId { get; set; }

        [Column(name: "token")]
        public string Token { get; set; }

        [Column(name: "token_expiration")]
        public DateTime ExpirationDate { get; set; }
    }
}