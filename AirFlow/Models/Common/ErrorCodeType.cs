namespace AirFlow.Models.Common
{
    public enum ErrorCodeType
    {
        UnknownError,

        MemberAlreadyExists,
        MemberNotFound,
        MemberHasNotConfirmedEmail,
        MemberHasAlreadyConfirmedEmail,
        MemberIsNotApprovedOrInvalidCredentials,

        ConfirmationTokenIsExpired,
        ConfirmationTokenInfoNotFound
    }
}