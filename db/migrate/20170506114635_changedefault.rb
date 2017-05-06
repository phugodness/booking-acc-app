class Changedefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :users, :role_id, 3
    change_column_default :users, :name, 'Stranger'
  end
end
