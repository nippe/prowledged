require 'rubygems'
require 'sinatra'
require 'json'
#$LOAD_PATH.unshift File.expand_path('./lib', __FILE__)
require './lib/notifiers/prowl_notifier'

get '/' do
  'This is a site for bridgeing a HTTP POST to Prowl'
end



def set_return_message_and_status
  content_type :json

  status 200
  {:status => 'OK', :status_description => "Message Sent"}.to_json
end



def send_message_and_set_return_message_and_status
  notifier = ProwlNotifier.new
  notifier.send_notification(params)
  set_return_message_and_status()
end


get '/:api_key/notification/send' do
  send_message_and_set_return_message_and_status()
end

post '/:api_key/notification/send/:priority' do
  send_message_and_set_return_message_and_status()
end



