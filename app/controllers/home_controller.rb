class HomeController < ApplicationController
  def index
    @rooms = Room.limit(6)
    @reservation = Reservation.new
    @q = Room.ransack(params[:q])
    @hash = []
    @rooms.each_with_index do |room, i|
      @hash[i] = Gmaps4rails.build_markers(room) do |r, marker|
        marker.lat r.latitude
        marker.lng r.longitude
      end
    end
    binding.pry
  end
end
