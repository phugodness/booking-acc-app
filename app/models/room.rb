class Room < ApplicationRecord
  belongs_to :type_of_room
  belongs_to :user
  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
end