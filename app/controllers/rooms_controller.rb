class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
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

    @reviews = @room.reviews.to_a
    @avg_rating = if @reviews.blank?
      0
    else
      @room.reviews.average(:rank).round(2)
    end
    gon.booked_date = []
    @room.room_reservations.includes(:reservation).map(&:reservation).collect do |x|
      x.checkin_date.upto(x.checkout_date) { |d| gon.booked_date << d.strftime('%d/%m/%Y') }
    end

    @hash = Gmaps4rails.build_markers(@room) do |room, marker|
      marker.lat room.latitude
      marker.lng room.longitude
      marker.json(
        custom_marker: "#{room.name}<br>#{room.price}$<br><img src='../img/home_marker.png' width='30' height='30'>"
      )
    end
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    params[:room][:user_id] = current_user.id.to_s
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        if params[:images]
          params[:images].each do |image|
            @room.image_rooms.create(image: image)
          end
        end
        CreatingRoomMailer.creating_room_email(current_user, @room).deliver_later
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
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
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  def init_data
    @type_of_room = TypeOfRoom.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.require(:room).permit(:type_of_room_id, :user_id, :name, :address, :number_of_guest, :price, :accomodates, :number_of_bed, :description, :house_rules, :longitude, :latitude)
  end
end
