﻿using System;
using System.Configuration;
using System.Data.SqlServerCe;
using System.Linq;
using System.Reflection;
using AirFlow.Data.Migrations.MirationUnit;
using PetaPoco;

namespace AirFlow.Data.Migrations
{
    public static class MigrationManager
    {
        public static void Process()
        {
            int currentVersion = GetCurrentVersion();
            Migration[] migrations = GetPendingMigrations(currentVersion);

            foreach (var migration in migrations)
            {
                RunBatches(migration);
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
                .ToArray();
        }

        private static int GetCurrentVersion()
        {
            using (var db = new Database(Config.ConnectionStringName))
            {
                return db.Fetch<int>("SELECT [version] FROM airFlowDbVersions").Single();
            }
        }

        public static void CreateVersionTable()
        {
            RunBatches(new InitialMigration());
        }

        private static void RunBatches(Migration migration)
        {
            string connectionString = ConfigurationManager.ConnectionStrings[Config.ConnectionStringName].ConnectionString;
            using (var conn = new SqlCeConnection(connectionString))
            {
                conn.Open();
                using (var tran = conn.BeginTransaction())
                {
                    string[] queries = migration.GetSqlQueries();
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
    }
}
