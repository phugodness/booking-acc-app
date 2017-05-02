class AddNumberOfRoomToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :number_of_room, :integer
  end
end
