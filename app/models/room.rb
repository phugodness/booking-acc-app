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

  def full_booked_days(number_of_room)
    booked_date = []
    available_reservations = reservations.reject { |a| a.status_id == 3 }
    available_reservations.collect do |x|
      x.checkin_date.upto(x.checkout_date) { |d| booked_date << d.strftime('%d/%m/%Y') }
    end
    booked_hash = booked_date.sort!.inject(Hash.new(0)) { |a, e| a[e] += 1; a }.reject{ |k, v| v < number_of_room }
    booked_hash.keys
  end
end
