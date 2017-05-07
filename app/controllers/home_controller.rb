class HomeController < ApplicationController
  def index
    @rooms = Room.includes(:type_of_room, :user, :amentity, :image_rooms).take(6)
    @most_rooms = Room.joins(:reservations).select("rooms.*, count(room_id) as rcount").group("rooms.id").order("rcount DESC").where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).take(3)
    @reservation = Reservation.new
    @q = Room.ransack(params[:q])
    @hash = []
    @most_hash = []
    @rooms.each_with_index do |room, i|
      @hash[i] = Gmaps4rails.build_markers(room) do |r, marker|
        marker.lat r.latitude
        marker.lng r.longitude
        marker.json(
          custom_marker: "#{r.name}<br>#{r.price}$<br><img src='../img/home_marker.png' width='30' height='30'>"
        )
      end
    end
    @most_rooms.each_with_index do |room, i|
      @most_hash[i] = Gmaps4rails.build_markers(room) do |r, marker|
        marker.lat r.latitude
        marker.lng r.longitude
        marker.json(
          custom_marker: "#{r.name}<br>#{r.price}$<br><img src='../img/home_marker.png' width='30' height='30'>"
        )
      end
    end
  end
end
