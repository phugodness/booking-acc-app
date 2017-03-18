class CreatingRoomMailer < ApplicationMailer
  def creating_room_email(user, room)
    @user = user
    @room = room
    mail(to: @user.email, subject: 'Confirming in creating your room')
  end
end
