class PublisherService
    def initialize
        @connection = Bunny.new(hostname: 'rabbitmq')
        @channel = connection.create_channel
    end

    def send(message)
        exchange = @channel.fanout("ping", durable: true)

        exchange.publish(message.to_json, timestamp: Time.now.to_i)
    end

    def connection 
        @connection.start
    end
end