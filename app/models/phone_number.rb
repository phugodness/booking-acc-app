class PhoneNumber < ApplicationRecord
  belongs_to :user

  def generate_pin
    self.pin = rand(0..9999).to_s.rjust(4, '0')
    save
  end

  def send_pin
    twilio_client.messages.create(to: phone_number, from: ENV['TWILIO_PHONE_NUMBER'], body: "Your PIN is #{pin}")
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def verify(entered_pin)
    update(verified: true) if pin == entered_pin
  end
end
