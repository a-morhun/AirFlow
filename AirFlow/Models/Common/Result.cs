namespace AirFlow.Models.Common
{
    public class Result
    {
        public ErrorCodeType? ErrorCode { get; protected set; }

        public bool IsSuccess
        {
            get { return !ErrorCode.HasValue; }
        }

        public string ErrorMessage { get; protected set; }

        public static Result Success
        {
            get { return new Result(); }
        }

        public Result()
        {
        }

        public Result(ErrorCodeType errorCode, string errorMessage = "")
        {
            ErrorCode = errorCode;
            ErrorMessage = errorMessage;
        }
    }
}