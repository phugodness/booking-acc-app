class Room < ApplicationRecord
  belongs_to :type_of_room
  belongs_to :user
  has_one :amentity
  has_many :image_rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :room_reservations
  geocoded_by :address # can also be an IP address
  after_validation :geocode # auto-fetch coordinates
end
