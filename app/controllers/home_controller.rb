class HomeController < ApplicationController
  def index
    @rooms = Room.limit(6)
    @reservation = Reservation.new
    # @hash = Gmaps4rails.build_markers(@room) do |room, marker|
    #   marker.lat room.latitude
    #   marker.lng room.longitude
    # end
  end
end
