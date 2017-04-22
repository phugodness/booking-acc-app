# a
class ReservationsController < ApplicationController
  protect_from_forgery except: [:hook]

  def hook
    params.permit!
    status = params[:payment_status]
    if status == 'Completed'
      @reservation = Reservation.find params[:invoice]
      @reservation.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

  def new
    @reservation = Reservation.new
  end

  def create
    a = params[:reservation][:checkin_date].split('-')
    params[:reservation][:checkin_date] = a[0]
    params[:reservation][:checkout_date] = a[1]

    @reservation = Reservation.new(reservation_params)
    # TODO do transaction
    if @reservation.save
      RoomReservation.create(room_id: params[:room_id], reservation_id: @reservation.id, status_id: 1)
      ReservationMailer.booking_room(current_user, @reservation).deliver_later
      redirect_to @reservation.paypal_url(room_path(id: params[:room_id]))
    else
      flash[:danger] = @reservation.errors.messages
      redirect_to room_path(id: params[:room_id])
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(Reservation::DEFAULT_PARAMS)
  end
end
