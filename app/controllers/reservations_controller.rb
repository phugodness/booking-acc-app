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
    @reservation.build_card
    @room = Room.find_by id: params['room_id']
  end

  def create
    params[:reservation][:checkin_date], params[:reservation][:checkout_date] = params[:reservation][:checkin_date].split('-')
    @reservation = Reservation.new(reservation_params)
    @reservation.card.ip_address = request.remote_ip
    if @reservation.save
      ReservationMailer.booking_room(current_user, @reservation).deliver_later
      case params['payment_method']
      when 'handon'
        redirect_to room_path(id: params[:reservation][:room_id]), notice: 'Success'
      when 'paypal'
        redirect_to @reservation.paypal_url(reservation_path(@reservation))
      when 'card'
        if @reservation.card.purchase
          binding.pry
          redirect_to room_path(id: params[:reservation][:room_id]), notice: @reservation.card.card_transaction.message
        else
          redirect_to room_path(id: params[:reservation][:room_id]), alert: @reservation.card.card_transaction.message
        end
      end
    else
      redirect_to room_path(id: params[:reservation][:room_id]), alert: @reservation.errors.messages
    end

  end

  private

  def reservation_params
    params.require(:reservation).permit(Reservation::DEFAULT_PARAMS << { card_attributes: [:first_name, :last_name, :card_type, :card_number, :card_verification, :card_expires_on] })
  end
end
