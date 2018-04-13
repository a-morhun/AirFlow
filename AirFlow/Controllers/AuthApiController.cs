//using System.Net;
//using System.Net.Http;
//using System.Web.Http;
//using AirFlow.Models.Common;
//using AirFlow.Services.Auth;
//using Umbraco.Web.WebApi;

//namespace AirFlow.Controllers
//{
//    [RoutePrefix("api/auth")]
//    public class AuthApiController : UmbracoApiController
//    {
//        private readonly IAuthService _authService;

//        public AuthApiController(IAuthService authService)
//        {
//            _authService = authService;
//        }

//        [HttpGet]
//        [Route("/registration/confirm")]
//        public IHttpActionResult ConfirmEmail(string token)
//        {
//            Result confirmationResult = _authService.ConfirmEmail(token);

//            if (confirmationResult.IsSuccess)
//            {
//                return ResponseMessage(new HttpResponseMessage(HttpStatusCode.OK));
//            }

//            return ResponseMessage(new HttpResponseMessage(HttpStatusCode.BadRequest));
//        }
//    }
//}