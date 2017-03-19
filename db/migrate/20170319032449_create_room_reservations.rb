class CreateRoomReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :room_reservations do |t|
      t.references :room, foreign_key: true
      t.references :reservation, foreign_key: true
      t.references :status, foreign_key: true

      t.timestamps
    end
  end
end
