using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace AirFlow.Data.Migrations.MirationUnit
{
    internal abstract class Migration
    {
        public int Version { get; }

        protected Migration(int version)
        {
            Version = version;
        }

        public virtual string[] GetSqlQueriesForSqlCe()
        {
            return GetSqlQueriesForSqlCe(this).ToArray();
        }

        private IEnumerable<string> GetSqlQueriesForSqlCe(Migration migration)
        {
            var assembly = Assembly.GetExecutingAssembly();
            var sqlScriptResource = $"{assembly.GetName().Name}.Migrations.Scripts.{migration.GetType().Name}.sql";
            var sqlScript = new StringBuilder();

            using (var stream = assembly.GetManifestResourceStream(sqlScriptResource))
            {
                if (stream == null)
                {
                    throw new InvalidOperationException($"resource not found {sqlScriptResource}");
                }

                using (var reader = new StreamReader(stream))
                {
                    while (reader.Peek() >= 0)
                    {
                        string line = reader.ReadLine().Replace("\t", string.Empty).Trim();

                        if (string.IsNullOrEmpty(line) || line.StartsWith("--"))
                        {
                            continue;
                        }

                        if (line == "GO")
                        {
                            yield return sqlScript.ToString();
                            sqlScript.Clear();
                            continue;
                        }

                        sqlScript.Append(line);
                    }
                }
            }

            yield return sqlScript.ToString();
        }
    }
}