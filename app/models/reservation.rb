class Reservation < ApplicationRecord
  DEFAULT_PARAMS = [:checkin_date, :checkout_date, :number_of_guest, :service_fee, :user_id, :status_id, :room_id, :total]

  belongs_to :user
  belongs_to :room
  belongs_to :status
  has_one :card, dependent: :destroy
  accepts_nested_attributes_for :card

  validate :booked_dates

  def booked_dates
    booked_date = []
    room = Room.find(room_id)
    available_reservations = room.reservations.reject { |a| a.status_id == 3 }
    available_reservations.collect do |x|
      x.checkin_date.upto(x.checkout_date) { |d| booked_date << d.strftime('%d/%m/%Y') }
    end
    booked_hash = booked_date.sort!.inject(Hash.new(0)) { |a, e| a[e] += 1; a }.reject{ |k, v| v < room.number_of_room }
    booked_hash.keys.each do |date|
      checkin_date.upto(checkout_date) do |x|
        return errors.add(:checkin_date, 'Your dates have been booked!') if x.strftime('%d/%m/%Y') == date
      end
    end
  end

  def payment_method
    card.nil? ? 'paypal' : 'card'
  end

  scope :confirmed, -> { where(status_id: 2) }

  validates :checkin_date, :checkout_date, :number_of_guest, :service_fee, presence: true
  validate :same_as_owner, on: :create

  def same_as_owner
    errors.add(:user_id, :same) if Room.find(room_id).user_id == user_id
  end

  def paypal_url(return_path)
    values = {
      business: 'phugodness-facilitator@gmail.com',
      cmd: '_xclick',
      upload: 1,
      return: "#{Rails.application.secrets.app_host}#{return_path}",
      invoice: id,
      amount: total,
      item_name: room.name + "(#{checkin_date} -- #{checkout_date})",
      item_number: number_of_guest,
      quantity: '1',
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
