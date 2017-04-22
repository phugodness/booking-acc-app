class Room < ApplicationRecord
  DEFAULT_PARAMS = [:type_of_room_id, :user_id, :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, :longitude, :latitude].freeze

  belongs_to :type_of_room
  belongs_to :user
  has_one :amentity
  has_many :image_rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :room_reservations

  validates :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, presence: true

  geocoded_by :address # can also be an IP address
  after_validation :geocode # auto-fetch coordinates
end
