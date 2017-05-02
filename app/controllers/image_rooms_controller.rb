class ImageRoomsController < ApplicationController
  before_action :set_image_room, only: [:destroy, :remove_image]
  def new
    @image_room = ImageRoom.new
  end

  def create
    @image_room = ImageRoom.create(image_room_params)
    if @image_room.save
      render json: { message: 'success', fileID: @image_room.id }, status: 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @image_room.errors.full_messages.join(',') }, status: 400
    end
  end

  def destroy
    if @image_room.destroy
      render json: { message: 'File deleted from server' }
    else
      render json: { message: @image_room.errors.full_messages.join(',') }
    end
  end

  def remove_image
    @image_room = ImageRoom.find(params[:id])
    if @image_room.destroy
      flash[:notice] = "Successfully deleted photo!"
      redirect_to :back
    else
      flash[:alert] = "Error deleting photo!"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image_room
    @image_room = ImageRoom.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_room_params
    params.require(:image_room).permit(:image, :room_id)
  end
end
