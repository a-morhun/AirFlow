using AirFlow.AirConditionUnits;
using AirFlow.Models.Common;
using AirFlow.Utilities;
using System;
using System.Web.Http;
using Umbraco.Web.WebApi;

namespace AirFlow.Controllers
{
    [Authorize]
    public class AirConditionUnitsController : UmbracoApiController
    {
        private readonly IAirConditionUnitService _airConditionUnitService;
        private readonly IAirFlowLogger _logger = new AirFlowLogger(typeof(AirConditionUnitsController));

        public AirConditionUnitsController(IAirConditionUnitService airConditionUnitService)
        {
            _airConditionUnitService = airConditionUnitService;
        }

        [HttpPost]
        [ActionName("Request")]
        public IHttpActionResult CreateTemperatureRequest(TemperatureRequest request)
        {
            _logger.Debug($"temperatuerRequest {request} from '{User.Identity?.Name}'");
            if (request.IsInvalid())
            {
                _logger.Warn("temperatuerRequest is invalid");
                return BadRequest();
            }

            if (request.RequestDateTime == null)
            {
                _logger.Info("temperatuerRequest has no time specified");
                request.RequestDateTime = DateTime.UtcNow;
            }

            Result result = _airConditionUnitService.CreateRequest(User.Identity.Name, request);
            _logger.Debug(result.ToString());

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
            _logger.Debug($"temperature history request for unit {id} from '{User.Identity?.Name}'");
            Result<TemperatureRequestHistory[]> history = _airConditionUnitService.GetRequestHistory(id);

            _logger.Debug(history.ToString());
            if (history.IsFailure)
            {
                return InternalServerError();
            }

            var response = new TemperatureRequestHistoryResponse(history.ReturnObject);
            _logger.Debug(response.ToString());

            return Ok(response);
        }
    }
}
