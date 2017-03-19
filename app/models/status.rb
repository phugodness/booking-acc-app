class Status < ApplicationRecord
  has_many :room_reservations
end
