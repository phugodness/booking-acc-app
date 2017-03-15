class AddRoomToAmentities < ActiveRecord::Migration[5.0]
  def change
    add_reference :amentities, :room, foreign_key: true
  end
end
