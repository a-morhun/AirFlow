namespace AirFlow.Data.Models
{
    public class AdditionalLoginInfo
    {
        public int UserId { get; set; }

        public string Username { get; set; }

        public byte LoginType { get; set; }
    }
}