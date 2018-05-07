using System;

namespace AirFlow.Data.AirConditionUnits
{
    public class AirConditionUnitRepositoryException : Exception
    {
        public AirConditionUnitRepositoryException(string message, Exception innterException) :
            base(message, innterException)
        {
        }
    }
}