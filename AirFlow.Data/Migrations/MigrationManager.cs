using AirFlow.Data.Migrations.MirationUnit;
using AirFlow.Utilities;
using PetaPoco;
using System;
using System.Configuration;
using System.Data.SqlServerCe;
using System.Linq;
using System.Reflection;
using System.Data.Common;
using System.Data.SqlClient;

namespace AirFlow.Data.Migrations
{
    public static class MigrationManager
    {
        private static readonly IAirFlowLogger Logger = new AirFlowLogger(typeof(MigrationManager));

        public static void Process()
        {
            Logger.Debug("Start migrations");
            int currentVersion = GetCurrentVersion();
            Logger.Debug($"Current DB version is '{currentVersion}'");
            Migration[] migrations = GetPendingMigrations(currentVersion);
            Logger.Debug($"Current Pending migration count is '{migrations.Length}'");

            foreach (var migration in migrations)
            {
                Execute(migration);
            }

            Logger.Debug("End migrations");
        }

        private static int GetCurrentVersion()
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                return db.Fetch<int>("SELECT [version] FROM airFlowDbVersions").Single();
            }
        }

        private static Migration[] GetPendingMigrations(int currentVersion)
        {
            return Assembly
                .GetExecutingAssembly()
                .GetTypes()
                .Where(t => t.IsSubclassOf(typeof(Migration)))
                .Select(t => (Migration)Activator.CreateInstance(t))
                .Where(m => m.Version > currentVersion)
                .OrderBy(m => m.Version)
                .ToArray();
        }

        public static void CreateVersionTable()
        {
            Execute(new InitialMigration());
        }

        private static void Execute(Migration migration)
        {
            Logger.Debug($"Execute migration '{migration.GetType().Name}'");
            try
            {
                ExecuteInternal(migration);
            }
            catch (Exception ex)
            {
                Logger.Fatal($"Failed to execute migration '{migration.GetType().Name}'", ex);
                throw;
            }
        }

        private static void ExecuteInternal(Migration migration)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[Config.ConnectionStringName].ConnectionString;
            using (DbConnection conn = GetConnection(connectionString))
            {
                conn.Open();
                using (var tran = conn.BeginTransaction())
                {
                    string[] queries = migration.GetSqlQueriesForSqlCe();
                    foreach (var query in queries)
                    {
                        var command = conn.CreateCommand();
                        command.CommandText = query;
                        command.ExecuteNonQuery();
                    }

                    tran.Commit();
                }
            }
        }

        private static DbConnection GetConnection(string connectionString)
        {
            string providerName = ConfigurationManager.ConnectionStrings[Config.ConnectionStringName].ProviderName;
            if (providerName.Contains("SqlServerCe"))
            {
                return new SqlCeConnection(connectionString);
            }
            else if (providerName.Contains("SqlClient"))
            {
                return new SqlConnection(connectionString);
            }

            throw new NotSupportedException($"'{providerName}' is not supported for AirFlow");
        }
    }
}
