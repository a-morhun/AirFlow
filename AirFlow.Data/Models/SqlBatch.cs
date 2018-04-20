namespace AirFlow.Data.Models
{
    internal class SqlBatch
    {
        public string Query { get; }

        public object[] Parameters { get; }

        public SqlBatch(string query, object[] parameters)
        {
            Query = query;
            Parameters = parameters;
        }
    }
}