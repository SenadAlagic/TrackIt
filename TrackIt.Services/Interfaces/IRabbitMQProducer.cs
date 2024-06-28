namespace TrackIt.Services.Interfaces
{
	public interface IRabbitMQProducer
	{

		public void SendMessage<T>(T message);
	}
}
