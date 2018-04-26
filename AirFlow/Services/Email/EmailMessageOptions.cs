namespace AirFlow.Services.Email
{
    public abstract class EmailMessageOptions
    {
        public string SendTo { get; }

        protected EmailMessageOptions(string sendTo)
        {
            SendTo = sendTo;
        }
    }
}