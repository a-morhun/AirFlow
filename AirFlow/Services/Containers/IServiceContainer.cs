namespace AirFlow.Services.Containers
{
    public interface IServiceContainer
    {
        T GetInstance<T>();

        T GetInstance<T>(ConstructorParameter parameter);
    }
}