class NotificationsBroadcastJob < ApplicationJob
  queue_as :default

  def perform(personal_message)
    message = render_message(personal_message)
    ApplicationCable.server.broadcast "conversations_#{personal_message.user.id}_channel",
                                      message: message,
                                      conversation_id: personal_message.conversation.id

    ApplicationCable.server.broadcast "conversations_#{personal_message.receiver.id}_channel",
                                      conversation: render_conversation(personal_message),
                                      message: message,
                                      conversation_id: personal_message.conversation.id
  end

  private

  def render_conversation
    ConversationsController.render partial: 'conversations/conversation', locals: { message: message }
  end

  def render_message
    PersonalMessageController.render partial: 'personal_messages/personal_message', locals: { personal_message: message }
  end
end
