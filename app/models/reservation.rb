class Reservation < ApplicationRecord
  DEFAULT_PARAMS = [:checkin_date, :checkout_date, :number_of_guest, :service_fee, :user_id].freeze

  belongs_to :user
  belongs_to :room
  belongs_to :status

  validates :checkin_date, :checkout_date, :number_of_guest, :service_fee, presence: true

  def paypal_url(return_path)
    values = {
      business: 'phugodness-facilitator@gmail.com',
      cmd: '_xclick',
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: room_reservation.room.price * number_of_guest + service_fee,
      rooms: room_reservation.room.name + "(#{checkin_date} -- #{checkout_date})",
      item_number: number_of_guest,
      quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
