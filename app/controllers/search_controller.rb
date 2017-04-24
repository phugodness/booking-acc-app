class SearchController < ApplicationController
  def index
    @q = Room.ransack(params[:q])
    @searched_rooms = @q.result
    @reservation = Reservation.new
  end
end
