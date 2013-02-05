require 'rubygems'
require 'sinatra'
require 'json'
require './lib/notifiers/prowl_notifier'

get '/' do
  'This is a site for bridging a HTTP POST to Prowl'
end



def set_return_message_and_status
  content_type :json

  status 200
  {:status => 'OK', :status_description => "Message Sent"}.to_json
end


def send_message_and_set_return_message_and_status event_description
  notifier = ProwlNotifier.new
  notifier.send_notification(params, event_description)
  set_return_message_and_status()
end


get '/:api_key/notification/send' do
  send_message_and_set_return_message_and_status(nil)
end

post '/:api_key/notification/send' do
  send_message_and_set_return_message_and_status()
end

post '/:api_key/notification/send/:priority' do
  send_message_and_set_return_message_and_status()
end

post '/:api_key/notification/:event/:priority' do
  if params[:event].eql?("stale")
    event = "#{params[:datastream]} is stale at #{params[:value]}"
  else
    event = "#{params[:datastream]} has passed threshold at #{params[:value]}"
  end
  send_message_and_set_return_message_and_status(event)
end



