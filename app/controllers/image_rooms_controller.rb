class ImageRoomsController < ApplicationController
  before_action :set_image_room, only: [:show, :edit, :update, :destroy]
  def new
    @image_room = ImageRoom.new
  end

  def index
    @image_room = ImageRoom.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/1/edit
  def edit
  end

  def create
    @image_room = ImageRoom.new(image_room_params)
    @image_room.product_id = params[:room_id]
    @image_room.image = params[:image]
    @image_room.save!
    render json: @image_room
  end

  def update
    respond_to do |format|
      if @image_room.update(image_room_params)
        format.html { redirect_to @image_room, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image_room }
      else
        format.html { render :edit }
        format.json { render json: @image_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image_room.destroy
    render nothing: true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image_room
    @image_room = ImageRoom.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_room_params
    params.require(:image_room).permit(:image_room_id, :image)
  end
end
