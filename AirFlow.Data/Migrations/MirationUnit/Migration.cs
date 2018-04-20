using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using AirFlow.Data.Models;

namespace AirFlow.Data.Migrations.MirationUnit
{
    internal abstract class Migration
    {
        public int Version { get; }

        protected Migration(int version)
        {
            Version = version;
        }

        public virtual string[] GetSqlQueries()
        {
            return GetSqlQueryBatches(this).ToArray();
        }

        private IEnumerable<string> GetSqlQueryBatches(Migration migration)
        {
            var assembly = Assembly.GetExecutingAssembly();
            string sqlScriptResource = $"{assembly.GetName().Name}.Migrations.Scripts.{migration.GetType().Name}.sql";
            var sqlScript = new StringBuilder();

            using (Stream stream = assembly.GetManifestResourceStream(sqlScriptResource))
            {
                if (stream == null)
                {
                    throw new InvalidOperationException($"resource not found {sqlScriptResource}");
                }

                using (StreamReader reader = new StreamReader(stream))
                {
                    while (reader.Peek() >= 0)
                    {
                        string line = reader.ReadLine().Replace("\t", String.Empty).Trim();

                        if (line == string.Empty)
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