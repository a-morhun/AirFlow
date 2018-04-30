using System;
using log4net;

namespace AirFlow.Utilities
{
    public class AirFlowLogger : IAirFlowLogger
    {
        private readonly ILog _logger;

        public AirFlowLogger(Type type)
        {
            _logger = LogManager.GetLogger(type.Namespace);
        }

        public void Debug(string message)
        {
            _logger.Debug(message);
        }

        public void Info(string message)
        {
            _logger.Info(message);
        }

        public void Warn(string message)
        {
            _logger.Warn(message);
        }

        public void Error(string message, Exception ex = null)
        {
            if (ex == null)
            {
                _logger.Error(message);
                return;
            }

            _logger.Error(message, ex);
        }


        public void Fatal(string message, Exception ex = null)
        {
            if (ex == null)
            {
                _logger.Fatal(message);
                return;
            }

            _logger.Fatal(message, ex);
        }
    }
}