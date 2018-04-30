using System;
using System.Runtime.CompilerServices;

namespace AirFlow.Utilities
{
    public interface IAirFlowLogger
    {
        void Debug(string message, [CallerMemberName] string caller = "");

        void Info(string message, [CallerMemberName] string caller = "");

        void Warn(string message, [CallerMemberName] string caller = "");

        void Error(string message, Exception ex = null, [CallerMemberName] string caller = "");

        void Fatal(string message, Exception ex = null, [CallerMemberName] string caller = "");
    }
}