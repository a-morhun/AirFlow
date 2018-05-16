using AirFlow.Data.Security.Account;
using System;

namespace AirFlow.Tests.Services.Account
{
    internal class UserAccountDtoResemblance : UserAccountDto
    {
        public override bool Equals(object obj)
        {
            var dto = obj as UserAccountDto;

            if (dto == null)
            {
                return base.Equals(obj);
            }

            return dto.UserId == UserId &&
                   dto.ConfirmationToken == ConfirmationToken &&
                   dto.ConfirmationExpirationDate > DateTime.UtcNow;
        }

        public override int GetHashCode()
        {
            return 0;
        }

        public static UserAccountDtoResemblance Construct(int userId, string confirmationToken, DateTime expirationDate)
        {
            return new UserAccountDtoResemblance
            {
                UserId = userId,
                ConfirmationToken = confirmationToken,
                ConfirmationExpirationDate = expirationDate
            };
        }
    }
}