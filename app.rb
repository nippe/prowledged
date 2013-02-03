require 'rubygems'
require 'sinatra'
require 'prowly'
require 'json'

get '/' do
  'Hey hey'
end

post '/:api_key/notification/send' do
  content_type :json

  Prowly.notify do |n|
    n.apikey = params[:api_key]
    n.priority = Prowly::Notification::Priority::EMERGENCY
    n.application = "Cosm"
    n.event = params[:event]
    n.event = "#{params[:datastream]} is #{params[:value]}"
    n.description = params[:description]
    n.url = 'http://cosm.com/feeds/100109'
  end

  status 200
  {:status => 'OK', :status_description => "Message Sent"}.to_json
end


