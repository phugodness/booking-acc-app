class Addfields < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservations, :room, index: true
    add_reference :reservations, :status, index: true
    add_column :reservations, :total, :integer
  end
end
