class CreateAmentities < ActiveRecord::Migration[5.0]
  def change
    create_table :amentities do |t|
      t.boolean :internet
      t.boolean :air_conditioning
      t.boolean :cable_tv
      t.boolean :breakfast
      t.boolean :parking
      t.boolean :elevator
      t.boolean :heating
      t.boolean :hot_tub

      t.timestamps
    end
  end
end
