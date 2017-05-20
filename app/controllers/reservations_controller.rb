# a
class ReservationsController < ApplicationController
  protect_from_forgery except: :hook
  # skip_before_action :verify_authenticity_token, only: [:hook]

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:notice] = "Successfully destroyed..."
    else
      flash[:alert] = "Can not Delete..."
    end
    redirect_to :back
  end

  def index
    page = params[:q][:page] if params[:q].present?
    per_page = 10
    per_page = params[:limit] if params[:limit]
    @reservations = current_user.reservations.includes(:user).order(:checkin_date).page(page).per(per_page)
  end

  def approve_reservations
    page = params[:q][:page] if params[:q].present?
    per_page = 10
    per_page = params[:limit] if params[:limit]
    @approve_reservations = Reservation.joins(:room).includes(:user, :room, :status).where(rooms: {user_id: current_user.id})
    @approve_reservations.page(page).per(per_page)
  end

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
      ReservationMailer.booking_room(Room.find(params[:reservation][:room_id]).user, @reservation).deliver_later
      ReservationMailer.booking_room(current_user, @reservation).deliver_later
      case params['payment_method']
      when 'handon'
        redirect_to room_path(id: params[:reservation][:room_id]), notice: 'Successfully'
      when 'paypal'
        redirect_to @reservation.paypal_url(room_path(id: params[:reservation][:room_id]))
      when 'card'
        if @reservation.card.purchase
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
