require 'twilio-ruby'
# require 'dotenv'


class SMS

  def initialize(client = Twilio::REST::Client.new(ENV['TWILIO_ACC'], ENV['TWILIO_AUTHTOKEN']))
    @client = client
  end


  def send_request_made
    @client.messages.create(
    to: ENV['TWILIO_DESTINATION_PHONE'],
    from: ENV['TWILIO_PHONE'],
    body: "You have requested a new space"
    )
  end
end
