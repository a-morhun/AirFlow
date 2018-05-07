using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Umbraco.Web.Mvc;
using Umbraco.Web;
using Umbraco.Core.Models;
using Archetype.Models;
using AirFlow.Models.Home;

namespace AirFlow.Controllers
{
    public class HomeController : SurfaceController
    {
        public ActionResult RenderHome()
        {
            IPublishedContent homePage = CurrentPage.AncestorOrSelf(1).DescendantsOrSelf().Where(x => x.DocumentTypeAlias == "home").FirstOrDefault();

            int mapImageId = homePage.GetPropertyValue<int>("map");
            string mapImageUrl = Umbraco.Media(mapImageId).Url;

            List<AirConditioner> airConditioners = new List<AirConditioner>();
            ArchetypeModel airConditionersConfigs = homePage.GetPropertyValue<ArchetypeModel>("airConditioners");
            foreach(ArchetypeFieldsetModel fieldset in airConditionersConfigs)
            {
                Guid id = fieldset.Id;
                string name = fieldset.GetValue<string>("name");
                int maxTemperature = fieldset.GetValue<int>("maxTemperature");
                int minTemperature = fieldset.GetValue<int>("minTemperature");
                var temperatureScaleId = fieldset.GetValue<int>("temperatureScale");
                string temperatureScale = Umbraco.GetPreValueAsString(temperatureScaleId);
                IPublishedContent image = fieldset.GetValue<IPublishedContent>("image");
                string imageUrl = image.Url;
                var isVertical = int.Parse(image.GetPropertyValue("umbracoHeight").ToString()) > int.Parse(image.GetPropertyValue("umbracoWidth").ToString());
                string positionX = fieldset.GetValue<string>("positionX");
                string positionY = fieldset.GetValue<string>("positionY");
                string width = fieldset.GetValue<string>("width");
                string height = fieldset.GetValue<string>("height");

                airConditioners.Add(new AirConditioner(id,
                    name, 
                    maxTemperature, 
                    minTemperature, 
                    temperatureScale,
                    imageUrl,
                    positionX,
                    positionY,
                    width,
                    height,
                    isVertical));
            }

            HomeModel homeModel = new HomeModel(mapImageUrl, airConditioners);
            return PartialView(GetPartialView("_Home"), homeModel);
        }

        public string GetPartialView(string partialViewName)
        {
            return $"~/Views/Partials/Home/{partialViewName}.cshtml";
        }
    }
}