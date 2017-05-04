class SearchController < ApplicationController
  def index
    @q = Room.ransack(params[:q])
    @searched_rooms = @q.result.includes(:type_of_room, :user, :amentity, :image_rooms, :reviews)
    @reservation = Reservation.new
    @hash = []
    @searched_rooms.each_with_index do |room, i|
      @hash[i] = Gmaps4rails.build_markers(room) do |r, marker|
        marker.lat r.latitude
        marker.lng r.longitude
        marker.json(
          custom_marker:  "<div style='text-align:center'>
                          #{r.name}
                          <div style='font-size: 16px'>
                          <b>#{r.price}$</b>
                          </div>
                          <img src='../img/home_marker.png' width='30' height='30'>
                          </div>"
        )
      end
    end
  end
end
