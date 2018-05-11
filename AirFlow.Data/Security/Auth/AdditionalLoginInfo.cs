namespace AirFlow.Data.Security.Auth
{
    public class AdditionalLoginInfo
    {
        public int UserId { get; set; }

        public string Username { get; set; }

        public byte LoginType { get; set; }
    }
}