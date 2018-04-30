using log4net;
using System;
using System.Runtime.CompilerServices;

namespace AirFlow.Utilities
{
    public class AirFlowLogger : IAirFlowLogger
    {
        private readonly ILog _logger;
        private readonly Type _targetType;

        public AirFlowLogger(Type type)
        {
            _targetType = type;
            _logger = LogManager.GetLogger(_targetType.Namespace);
        }

        public void Debug(string message, [CallerMemberName] string caller = "")
        {
            _logger.Debug(FormatMessage(message, caller));
        }

        public void Info(string message, [CallerMemberName] string caller = "")
        {
            _logger.Info(FormatMessage(message, caller));
        }

        public void Warn(string message, [CallerMemberName] string caller = "")
        {
            _logger.Warn(FormatMessage(message, caller));
        }

        public void Error(string message, Exception ex = null, [CallerMemberName] string caller = "")
        {
            if (ex == null)
            {
                _logger.Error(FormatMessage(message, caller));
                return;
            }

            _logger.Error(FormatMessage(message, caller), ex);
        }


        public void Fatal(string message, Exception ex = null, [CallerMemberName] string caller = "")
        {
            if (ex == null)
            {
                _logger.Fatal(FormatMessage(message, caller));
                return;
            }

            _logger.Fatal(FormatMessage(message, caller), ex);
        }

        private string FormatMessage(string message, string caller)
        {
            return $"[{_targetType.Name} {caller}] {message}";
        }
    }
}