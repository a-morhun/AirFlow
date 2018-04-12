using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AirFlow.Models.Account
{
    public class UserRegistrationFactory
    {
        public static UserRegistration GetUserRegistrationStrategy(UserType type)
        {
            //switch (type)
            //{
            //    case UserType.ValtechUk:
            //        return new ValtechUkUserRegistration();

            //    default:
            //        return new RegularUserRegistration();
            //}

            return null;
        }
    }
}