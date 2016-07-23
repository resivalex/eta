#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'
require './geo.rb'

conn = Bunny.new
conn.start

ch = conn.create_channel

class EtaServer
  def initialize(ch)
    @ch = ch
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

    distance = Geo.harvestine_distance(46.3625, 15.114444, latitude, longitude)
    distance_to_eta(distance).to_s
  rescue
    'Wrong format'
  end

  def distance_to_eta(d)
    (d / 1000) * 1.5
  end
end

begin
  server = EtaServer.new(ch)
  puts " [x] Awaiting RPC requests"
  server.start("rpc_queue")
rescue Interrupt => _
  ch.close
  conn.close
end
