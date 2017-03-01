class CreateImageRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :image_rooms do |t|
      t.references :room, foreign_key: true
      t.attachment :image

      t.timestamps
    end
  end
end
