class ReviewsController < ApplicationController
  def create
    params[:review][:user_id] = current_user.id
    @room = Room.find(params[:room_id])
    @review = @room.reviews.create!(review_params)
    redirect_to room_path(@room)
  end

  private

  def review_params
    params.require(:review).permit(:room_id, :user_id, :rank, :comment)
  end
end
