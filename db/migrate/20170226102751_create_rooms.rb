class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :type_of_room, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.string :address
      t.integer :number_of_guest
      t.integer :price
      t.integer :accomodates
      t.integer :number_of_bed
      t.string :description
      t.string :house_rules
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
