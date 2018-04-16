using Umbraco.Core.Models;
using Umbraco.Web.Models;

namespace AirFlow.Models.Common
{
    public class ResultViewModel
    {
        public string Message { get; }

        public bool IsSuccess { get; }

        public ResultViewModel(string message, bool isSuccess)
        {
            Message = message;
            IsSuccess = isSuccess;
        }
    }
}