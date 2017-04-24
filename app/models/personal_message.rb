# Message of people
class PersonalMessage < ApplicationRecord
  DEFAULT_PARAMS = [:body, :conversation_id, :user_id].freeze

  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  after_create_commit do
    conversation.touch
    NotificationsBroadcastJob.perform_later(self)
  end
end
