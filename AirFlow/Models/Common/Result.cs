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

        public override string ToString()
        {
            return $"IsSuccess: {IsSuccess}, ErrorCode: {ErrorCode}";
        }
    }

    public class Result<TReturn> : Result
    {
        public TReturn ReturnObject { get; }

        public Result(TReturn returnObject)
        {
            ReturnObject = returnObject;
        }

        public Result(ErrorCodeType errorCode, string errorMessage = "")
            : base(errorCode, errorMessage)
        {
        }
    }

}