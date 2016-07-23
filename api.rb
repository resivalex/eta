require './eta_client.rb'
require 'sinatra'

get '/eta' do
  conn = Bunny.new(automatically_recover: false)
  conn.start

  ch   = conn.create_channel

  client   = EtaClient.new(ch, 'rpc_queue')
  puts ' [x] Requesting eta'
  response = client.call(params[:coord])

  ch.close
  conn.close

  response
end
