using AirFlow.App_Start;
using AirFlow.Data.Migrations;
using System;
using System.Web.Optimization;
using System.Web.Routing;
using Umbraco.Core;
using Umbraco.Web;

namespace AirFlow
{
    public class AirFlowApplication : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            AutofacConfig.Configure();
            MigrationManager.Process();
            SecurityConfig.Initialize();
        }

        protected override void OnApplicationStarting(object sender, EventArgs e)
        {
            var dbContext = ApplicationContext.Current.DatabaseContext;

            // For now only SQL CE db in use. So if CanConnect is false - no .sdf file exists
            if (dbContext.CanConnect == false)
            {
                CreateBrandNewSqlCEDatabase(dbContext);
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