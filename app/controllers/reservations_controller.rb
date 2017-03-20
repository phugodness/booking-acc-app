class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
  end
  def create
    a = params[:reservation][:checkin_date].split('-')
    params[:reservation][:checkin_date] = a[0]
    params[:reservation][:checkout_date] = a[1]

    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      RoomReservation.create(room_id: params[:room_id], reservation_id: @reservation.id, status_id: 1)
      ReservationMailer.booking_room(current_user, @reservation).deliver_later
      flash[:success] = 'successfully'
      redirect_to :back
    else
      flash[:danger] = 'failed'
    end
  end
  private
    def reservation_params
      params.require(:reservation).permit(Reservation::DEFAULT_PARAMS << :room_id, :user_id)
    end
end
