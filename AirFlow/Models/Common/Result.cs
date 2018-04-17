namespace AirFlow.Models.Common
{
    public class Result
    {
        public ErrorCodeType? ErrorCode { get; protected set; }

        public string ErrorMessage { get; protected set; }

        public bool IsSuccess => !ErrorCode.HasValue;

        public bool IsFailure => ErrorCode.HasValue;

        public static Result Success => new Result();

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