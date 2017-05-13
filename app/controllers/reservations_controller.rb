# a
class ReservationsController < ApplicationController
  protect_from_forgery except: :hook
  # skip_before_action :verify_authenticity_token, only: [:hook]

  def hook
    params.permit!
    status = params[:payment_status]
    if status == 'Completed'
      @reservation = Reservation.find params[:invoice]
      # @reservation.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
      @reservation.update(status_id: 2)
    end
    render nothing: true
  end

  def new
    @reservation = Reservation.new
  end

  def create
    params[:reservation][:checkin_date], params[:reservation][:checkout_date] = params[:reservation][:checkin_date].split('-')

    @reservation = Reservation.new(reservation_params)
    ActiveRecord::Base.transaction do
      begin
        @reservation.save
        ReservationMailer.booking_room(current_user, @reservation).deliver_later
        redirect_to @reservation.paypal_url(room_path(id: params[:reservation][:room_id]))
      rescue StandardError
        flash[:danger] = @reservation.errors.messages
        redirect_to room_path(id: params[:reservation][:room_id])
      end
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(Reservation::DEFAULT_PARAMS)
  end
end
