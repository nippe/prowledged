require 'rubygems'
require 'sinatra'
require 'prowly'
require 'json'

get '/' do
  'Hey hey'
end

def get_severity(severity)
  if(severity.nil?)
    Prowly::Notification::Priority::MODERATE
  else
    Prowly::Notification::Priority::EMERGENCY
  end
end

def send_notification(indata)
  Prowly.notify do |n|
    n.apikey = indata[:api_key]
    n.priority = get_severity(indata[:priority])
    n.application = "Cosm"
    n.event = indata[:event]
    n.event = "#{indata[:datastream]} is #{indata[:value]}"
    n.description = indata[:description]
    n.url = 'http://cosm.com/feeds/100109'
  end
end


def set_return_message_and_status
  content_type :json

  status 200
  {:status => 'OK', :status_description => "Message Sent"}.to_json
end

post '/:api_key/notification/send' do
  send_notification(params)
  set_return_message_and_status()
end


post '/:api_key/notification/send/:priority' do
  send_notification(params)
  set_return_message_and_status()
end



