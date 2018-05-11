using AirFlow.Data.Migrations;
using AirFlow.Utilities;
using System;
using System.Web.Optimization;
using System.Web.Routing;
using Umbraco.Core;
using Umbraco.Core.Persistence;
using Umbraco.Web;

namespace AirFlow
{
    public class AirFlowApplication : UmbracoApplication
    {
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AirFlowApplication));

        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            _logger.Debug("===Application configuration START===");
            base.OnApplicationStarted(sender, e);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            AutofacConfig.Configure();
            MigrationManager.Process();
            SecurityConfig.Initialize();
            _logger.Debug("Application configuration END");
        }

        protected override void OnApplicationStarting(object sender, EventArgs e)
        {
            var dbContext = ApplicationContext.Current.DatabaseContext;

            if (dbContext.CanConnect == false)
            {
                try
                {
                    CreateBrandNewSqlCEDatabase(dbContext);
                }
                catch (Exception exception)
                {
                    _logger.Fatal("Failed to create database", exception);
                    throw;
                }

                _logger.Debug("Created new database");
            }

            base.OnApplicationStarting(this, e);
        }

        private void CreateBrandNewSqlCEDatabase(DatabaseContext dbContext)
        {
            ConfigureDatabaseConnection(dbContext);
            MigrationManager.CreateVersionTable();
        }

        private void ConfigureDatabaseConnection(DatabaseContext dbContext)
        {
            if (dbContext.DatabaseProvider == DatabaseProviders.SqlServerCE)
            {
                dbContext.ConfigureEmbeddedDatabaseConnection();
                return;
            }
            else if (dbContext.DatabaseProvider == DatabaseProviders.SqlServer)
            {
                dbContext.ConfigureDatabaseConnection(dbContext.ConnectionString);
                return;
            }

            throw new Exception($"{dbContext.DatabaseProvider} is not supported");
        }
    }
}