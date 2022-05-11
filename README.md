# RabbitMQ Tutorial in Ruby and Docker

In this project, we've created three services:
* Producer - Ping;
* Consumer - Pong;
* Broker - RabbitMQ.

## 1. Starting a project with Docker and Rails

To configure your project with Docker and Ruby on Rails, follow [Docker's Quickstart: Compose and Rails](https://docs.docker.com/samples/rails/).

## 2. RabbitMQ

In this proejct, you'll only need to configure three files: 
* `deffinitions.json`, where you can set user permissions, create queues, exchanges, etc.;
* `docker-compose.yml`;
* `rabbitmq.config`.

### 2.1. Running RabbitMQ

Just boot your application with the following command:

```
$ docker-compose up
```

RabbitMQ admin panel will be available on `localhost:15672`.

## 3. Producer

Into the folder `ping/app/services`, we've created the file `publisher_service.rb`. There, you'll start a connection, create a channel and send a message through the exchange previously created on RabbitMQ's `deffinitions.json`.

Since we're using the Bunny gem to do this, you'll need to add it to your `Gemfile`:

```
gem 'bunny', '~> 2.14', '>= 2.14.2'
```

### 3.1. Running the Producer

Our producer will be responsible to send messages to our broker. We can do that by running the following commands on our Terminal:
```
$ docker-compose run web bundle exec rails c
> service = PublisherService.new()
> service.send("hello, world")
```

## 4. Consumer

In this case, you'll need to create a Worker that will check if there's any message in the queue. You'll find this on `pong/app/workers/pong_subscriber.rb`. This worker works with the gem Sneakers, so don't forget to add these to your `Gemfile`: 

```
gem 'bunny', '~> 2.14', '>= 2.14.2'
gem 'sneakers'
```

If you followed Docker's tutorial, don't forget to **change the port number** on your `docker-compose.yml` file, so your producer and your consumer won't be using the same port.

### 4.1. Running the Consumer

In this case, you'll need to run your Worker to check if there's any message on the queue:

```
$ docker-compose run web bundle exec rake sneakers:run
```

## 5. Shared Network

We need to create a network so our services can communicate with each other. This info will be added to the `docker-compose.yml` file. RabbitMQ will be responsible to create the network, and the other services will access it. When running the services, remember to boot RabbitMQ first, since it'll create the network used by the other services. The network can also be manually created with the command:
```
$ docker network create <network_name>
```

## Useful commands

To check your command history on Linux Terminal, execute the line below:
```
$ history | grep "db:create"
```
To remove the `.git` folder from a project, making it a non-git directory:
```
$ rm -rf .git
```