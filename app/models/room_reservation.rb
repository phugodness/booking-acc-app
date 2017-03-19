class RoomReservation < ApplicationRecord
  belongs_to :room
  belongs_to :reservation
  belongs_to :status
end
