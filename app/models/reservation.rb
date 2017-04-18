class Reservation < ApplicationRecord
  belongs_to :user
  has_one :room_reservation
  DEFAULT_PARAMS = [:checkin_date, :checkout_date, :number_of_guest, :service_fee]
  def paypal_url(return_path)
    values = {
        business: "phugodness-facilitator@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: room_reservation.room.price * number_of_guest + service_fee,
        item_name: room_reservation.room.name + "(#{checkin_date} -- #{checkout_date})",
        item_number: number_of_guest,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
