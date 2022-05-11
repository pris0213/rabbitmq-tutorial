class PongSubscriber
    include Sneakers::Worker

    from_queue "ping.sent", exchange: "ping", exchange_options: { type: "fanout" }

    def work_with_params(message, delivery_info, metadata)
        puts "Message: #{message}"
        return ack!
    end
end