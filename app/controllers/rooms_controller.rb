class RoomsController < ApplicationController
  load_and_authorize_resource
  before_action :set_room, only: [:show, :edit, :update, :destroy, :images]
  before_action :init_data
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all.includes(:type_of_room, :user)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @reservation = Reservation.new
    @room = Room.includes(:type_of_room, :user).find_by_id(params[:id])
    @card = @reservation.build_card
    # reviews of room
    @reviews = @room.reviews.to_a
    @avg_rating = @reviews.blank? ? 0 : @room.reviews.average(:rank).round(2)
    # booked dates
    gon.booked_date = []
    @room.reservations.collect do |x|
      x.checkin_date.upto(x.checkout_date) { |d| gon.booked_date << d.strftime('%d/%m/%Y') }
    end
    gon.booked_date.sort!
    # Google map
    @hash = Gmaps4rails.build_markers(@room) do |room, marker|
      marker.lat room.latitude
      marker.lng room.longitude
      marker.json(
        custom_marker: "<div style='text-align:center'>
        #{room.name}
        <div style='font-size: 16px'>
        <b>#{room.price}$</b>
        </div>
        <img src='../img/home_marker.png' width='30' height='30'>
        </div>"
      )
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @room.build_amentity
  end

  # GET /rooms/1/edit
  def edit
    @image_room = ImageRoom.new
  end

  # POST /rooms
  # POST /rooms.json
  def create
    params[:room][:user_id] = current_user.id.to_s
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        CreatingRoomMailer.creating_room_email(current_user, @room).deliver_later
        format.html { redirect_to new_image_room_path(room_id: @room.id) }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def images
    @images = @room.image_rooms
    render json: @images.to_json(methods: :url_medium)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.includes(:amentity).find(params[:id])
  end

  def init_data
    @type_of_room = TypeOfRoom.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(Room::DEFAULT_PARAMS << { amentity_attributes: Amentity:: DEFAULT_PARAMS })
  end
end
