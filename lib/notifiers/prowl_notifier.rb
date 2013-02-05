require 'prowly'


class ProwlNotifier

  def get_severity(severity)
    if severity.nil?
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

end