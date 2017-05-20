class NotificationsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(personal_message)
    ActionCable.server.broadcast "notifications_channel",
                                 message: personal_message,
                                 conversation_id: personal_message.conversation.id
  end

  private

  def render_notification(message)
    NotificationsController.render partial: 'notifications/notification', locals: {message: message}
  end

  def render_message(message)
    PersonalMessagesController.renderer.render partial: 'personal_messages/personal_message',
                                      locals: {personal_message: message}
  end
end
