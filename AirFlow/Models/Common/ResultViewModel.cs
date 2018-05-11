namespace AirFlow.Models.Common
{
    public class ResultViewModel
    {
        public string Message { get; }

        public bool IsSuccess { get; }

        public bool IsFailure => !IsSuccess;

        public ResultViewModel(string message, bool isSuccess)
        {
            Message = message;
            IsSuccess = isSuccess;
        }
    }
}