class Reservation < ApplicationRecord
  belongs_to :user
  has_one :room_reservation
end
