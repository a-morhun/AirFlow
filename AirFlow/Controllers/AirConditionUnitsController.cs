using AirFlow.AirConditionUnits;
using AirFlow.Models.Common;
using System;
using System.Web.Http;
using Umbraco.Web.WebApi;

namespace AirFlow.Controllers
{
    [Authorize]
    public class AirConditionUnitsController : UmbracoApiController
    {
        private readonly IAirConditionUnitService _airConditionUnitService;

        public AirConditionUnitsController(IAirConditionUnitService airConditionUnitService)
        {
            _airConditionUnitService = airConditionUnitService;
        }

        [HttpPost]
        [ActionName("Request")]
        public IHttpActionResult CreateTemperatureRequest(TemperatureRequest request)
        {
            if (request.IsInvalid())
            {
                return BadRequest();
            }

            if (request.RequestDateTime == null)
            {
                request.RequestDateTime = DateTime.UtcNow;
            }

            Result result = _airConditionUnitService.CreateRequest(User.Identity.Name, request);
            if (result.IsFailure)
            {
                return InternalServerError();
            }

            return Ok();
        }

        [HttpGet]
        [ActionName("History")]
        public IHttpActionResult GetTemperatureRequestHistory(int id)
        {
            Result<TemperatureRequestHistory[]> history = _airConditionUnitService.GetRequestHistory(id);

            if (history.IsFailure)
            {
                return InternalServerError();
            }

            return Ok(new TemperatureRequestHistoryResponse(history.ReturnObject));
        }
    }
}
