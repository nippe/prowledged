require 'rubygems'
require 'sinatra'
require 'prowly'


get '/' do
  'Hey hey'
end

get '/:api_key/notification/send' do
  key = params[:api_key]

  Prowly.notify do |n|
    n.apikey = key
    n.priority = Prowly::Notification::Priority::MODERATE
    n.application = "Cosm"
    n.event = params[:event]
    n.event = "#{params[:datastream]} is #{params[:value]}"
    n.description = params[:description]
    n.url = 'http://cosm.com/feeds/100109'
  end
end


