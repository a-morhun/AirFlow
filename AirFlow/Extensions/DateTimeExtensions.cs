using System;

namespace AirFlow.Extensions
{
    public static class DateTimeExtensions
    {
        public static string ToStringWithTimeZone(this DateTime dateTimeUtc, string timeZoneId)
        {
            (DateTime final, TimeSpan offset) = GetDateTimeOffset(dateTimeUtc, timeZoneId);
            return $@"Date: {final:dd-MM-yyyy} Time: {final:HH:mm:ss} UTC{(offset.Hours > 0 ? "+" : "-")}{offset:hh\:mm}";
        }

        public static DateTime ApplyTimeZone (this DateTime datetime, string timeZoneId)
        {
            (DateTime final, _) = GetDateTimeOffset(datetime, timeZoneId);
            return final;
        }

        private static (DateTime Final, TimeSpan Offset) GetDateTimeOffset(DateTime dateTimeUtc, string timeZoneId)
        {
            TimeZoneInfo info = TimeZoneInfo.FindSystemTimeZoneById(timeZoneId);
            bool isDaylightSaving = info.IsDaylightSavingTime(dateTimeUtc);
            TimeSpan offset = isDaylightSaving ? info.BaseUtcOffset.Add(TimeSpan.FromHours(1)) : info.BaseUtcOffset;

            return (Final: dateTimeUtc.Add(offset), Offset: offset);
        }
    }
}