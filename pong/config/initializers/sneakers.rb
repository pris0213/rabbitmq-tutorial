require "sneakers"
Sneakers.configure(connection: Bunny.new(hostname: 'rabbitmq'), log: "sneakers.log", workers: 1)
