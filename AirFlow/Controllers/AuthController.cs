using AirFlow.Models.Auth;
using System.Web.Mvc;
using Umbraco.Web.Mvc;

namespace AirFlow.Controllers
{
    // TODO: should be rewritten using API controller
    public class AuthController : SurfaceController
    {
    //    public ActionResult RenderLogin()
    //    {
    //        return PartialView("~/Auth/_Login", new LoginViewModel());
    //    }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Login(UserLoginViewModel loginRequest)
        {

            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {

            return null;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [AllowAnonymous]
        public ActionResult Register(UserRegistrationViewModel registrationRequest)
        {


            return null;
        }
    }
}