using Autofac;
using System;

namespace AirFlow.Services.Containers
{
    internal sealed class AirFlowServiceContainer : IServiceContainer
    {
        private static Lazy<AirFlowServiceContainer> _lazy => new Lazy<AirFlowServiceContainer>(() => new AirFlowServiceContainer());

        public static AirFlowServiceContainer Instance => _lazy.Value;

        private static IContainer _container;

        public static void SetContainer(IContainer container)
        {
            _container = container;
        }

        public T GetInstance<T>()
        {
            return _container.Resolve<T>();
        }

        public T GetInstance<T>(ConstructorParameter parameter)
        {
            return _container.Resolve<T>(new NamedParameter(parameter.Name, parameter.Value));
        }
    }
}