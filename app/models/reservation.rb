class Reservation < ApplicationRecord
  DEFAULT_PARAMS = [:checkin_date, :checkout_date, :number_of_guest, :service_fee, :user_id, :status_id, :room_id, :total]

  belongs_to :user
  belongs_to :room
  belongs_to :status
  has_one :card
  accepts_nested_attributes_for :card

  def payment_method
    if card.nil? then "paypal"; else "card"; end
  end

  validates :checkin_date, :checkout_date, :number_of_guest, :service_fee, presence: true
  validate :same_as_owner

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
      rooms: room.name + "(#{checkin_date} -- #{checkout_date})",
      item_number: number_of_guest,
      quantity: '1',
      notify_url: "#{Rails.application.secrets.app_host}/hook"
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end
