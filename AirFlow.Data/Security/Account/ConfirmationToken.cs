namespace AirFlow.Data.Security.Account
{
    public class ConfirmationToken : Token
    {
        public bool AlreadyConfirmed { get; set; }

        public override string ToString()
        {
            return $"{base.ToString()}, AlreadyConfirmed: {AlreadyConfirmed}";
        }
    }
}