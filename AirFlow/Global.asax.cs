using AirFlow.Data.Migrations;
using AirFlow.Utilities;
using System;
using System.Web.Optimization;
using System.Web.Routing;
using Umbraco.Core;
using Umbraco.Web;

namespace AirFlow
{
    public class AirFlowApplication : UmbracoApplication
    {
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AirFlowApplication));

        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            _logger.Debug("Application configuration START");
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

            // For now only SQL CE db in use. So if CanConnect is false - no .sdf file exists
            if (dbContext.CanConnect == false)
            {
                try
                {
                    CreateBrandNewSqlCEDatabase(dbContext);
                }
                catch (Exception exception)
                {
                    _logger.Fatal("Failed to create SQL CE database", exception);
                    throw;
                }
               
                _logger.Debug("Created new SQL CE database");
            }

            base.OnApplicationStarting(this, e);
        }

        private void CreateBrandNewSqlCEDatabase(DatabaseContext dbContext)
        {
            dbContext.ConfigureEmbeddedDatabaseConnection();
            MigrationManager.CreateVersionTable();
        }
    }
}