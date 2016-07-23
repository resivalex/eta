require './eta_server.rb'
require './car_park.rb'

connection = Bunny.new
connection.start

channel = connection.create_channel
car_park = CarPark.new

begin
  server = EtaServer.new(channel, car_park)
  puts " [x] Awaiting RPC requests"
  server.start("rpc_queue")
rescue Interrupt => _
  channel.close
  connection.close
end
