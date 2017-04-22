class ReviewsController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    review = room.reviews.create(review_params)
    if review.save
      flash[:success] = "successfully"
    else
      flash[:danger] = review.errors.messages
    end
    redirect_to room_path(room)
  end

  private

  def review_params
    params.require(:review).permit(:room_id, :user_id, :rank, :comment)
  end
end
