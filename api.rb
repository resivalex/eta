require './eta_client.rb'
require 'json'
require 'sinatra'

get '/eta' do
  content_type :json

  connection = Bunny.new(automatically_recover: false)
  connection.start

  channel = connection.create_channel

  client = EtaClient.new(channel, 'rpc_queue')
  response = client.call("#{params[:lat]} #{params[:long]}")

  channel.close
  connection.close

  begin
    { eta: Float(response) }.to_json
  rescue
    { error: response }.to_json
  end
end
