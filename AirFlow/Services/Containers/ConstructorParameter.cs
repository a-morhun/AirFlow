namespace AirFlow.Services.Containers
{
    public struct ConstructorParameter
    {
        public string Name { get; set; }

        public object Value { get; set; }

        public ConstructorParameter(string name, object value)
        {
            Name = name;
            Value = value;
        }
    }
}