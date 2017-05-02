class AddCodeToTypeOfRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :type_of_rooms, :code, :string
  end
end
