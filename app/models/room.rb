class Room < ApplicationRecord
  DEFAULT_PARAMS = [:type_of_room_id, :user_id, :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, :longitude, :latitude, :number_of_room]

  belongs_to :type_of_room
  belongs_to :user
  has_one :amentity, dependent: :destroy
  has_many :image_rooms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, presence: true

  accepts_nested_attributes_for :amentity

  geocoded_by :address # can also be an IP address
  after_validation :geocode # auto-fetch coordinates
end
