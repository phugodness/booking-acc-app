class Review < ApplicationRecord
  DEFAULT_PARAMS = [:room_id, :user_id, :rank, :comment].freeze

  belongs_to :room
  belongs_to :user

  validates :rank, :comment, presence: true
end
