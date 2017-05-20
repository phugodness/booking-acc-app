class PhoneNumber < ApplicationRecord
  belongs_to :user

  def generate_pin
    self.pin = rand(0..9999).to_s.rjust(4, '0')
    save
  end

  def send_pin
    twilio_client.messages.create(to: phone_number, from: Rails.application.secrets.twilio_number, body: "Your PIN is #{pin}")
  end

  def twilio_client
    Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
  end

  def verify(entered_pin)
    if pin == entered_pin
      update(verified: true)
      user.update(role_id: 2)
    end
  end
end
