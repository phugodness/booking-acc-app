class ReservationMailer < ApplicationMailer
  def booking_room(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: 'Booking Room')
  end
end
