class SearchController < ApplicationController
  def index
    q_param = params[:q]
    page = params[:q][:page]
    per_page = params[:limit] if params[:limit]
    @q = Room.ransack(q_param)
    @searched_rooms = @q.result.includes(:type_of_room, :user, :amentity, :image_rooms, :reviews).page(page).per(per_page)
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
