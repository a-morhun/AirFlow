using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    public class ConfirmationController : RenderMvcController
    {
        public override ActionResult Index(RenderModel model)
        {
            var myModel = new MyViewModel(model);
            return base.Index(myModel);
        }
    }

    public class MyViewModel : RenderModel
    {
        public MyViewModel(RenderModel model) : base (model.Content, model.CurrentCulture)
        {
        }

        public string MyString => "It works!";
    }
}