class Reservation < ApplicationRecord
  belongs_to :user
  has_one :room_reservation
  DEFAULT_PARAMS = [:checkin_date, :checkout_date, :number_of_guest, :service_fee]
end
