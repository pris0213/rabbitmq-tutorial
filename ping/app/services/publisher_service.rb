class PublisherService
    def initialize
        @connection = Bunny.new(hostname: 'rabbitmq')
        @channel = connection.create_channel
    end

    def send(message)
        exchange = channel.fanout("ping", durable: true)

        exchange.publish("teste".to_json, timestamp: Time.now.to_i)
    end

    def channel
        @channel = connection.create_channel
    end

    def connection 
        @connection.start
    end
end