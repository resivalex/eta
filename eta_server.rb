require 'bunny'
require './geo.rb'

class EtaServer
  def initialize(ch, car_park)
    @ch = ch
    @car_park = car_park
  end

  def start(queue_name)
    @q = @ch.queue(queue_name)
    @x = @ch.default_exchange

    @q.subscribe(:block => true) do |delivery_info, properties, payload|
      response = process(payload)
      puts response
      @x.publish(response, routing_key: properties.reply_to, correlation_id: properties.correlation_id)
    end
  end

  def process(request)
    latitude, longitude = request.split(' ').map { |s| Float(s) }

    raise ArgumentError unless (-90.0..90.0).cover?(latitude)
    raise ArgumentError unless (0.0..180.0).cover?(longitude)

    @car_park.eta(latitude, longitude).to_s
  # rescue
  #   'Wrong format'
  end
end
