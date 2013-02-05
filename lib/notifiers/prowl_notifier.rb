require 'prowly'


class ProwlNotifier

  def get_severity(severity)
    if severity.nil?
      Prowly::Notification::Priority::MODERATE
    else
      Prowly::Notification::Priority::EMERGENCY
    end
  end

  def send_notification(indata, event_description)
    Prowly.notify do |n|
      n.apikey = indata[:api_key]
      n.priority = get_severity(indata[:priority])
      n.application = "Cosm"
      if event_description.nil?
        n.event="#{indata[:datastream]} is #{indata[:event]} at #{indata[:value]}"
      else
        n.event = event_description
      end
      n.description = indata[:description]
      n.url = 'http://cosm.com/feeds/100109'
    end
  end

end