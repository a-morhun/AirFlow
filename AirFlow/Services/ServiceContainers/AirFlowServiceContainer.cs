using Autofac;

namespace AirFlow.ServiceContainers
{
    public static class AirFlowServiceContainer
    {
        public static IContainer Container { get; private set; }

        public static void SetContainer(IContainer container)
        {
            Container = container;
        }
    }
}