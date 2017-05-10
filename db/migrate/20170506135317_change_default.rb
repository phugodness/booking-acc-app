class ChangeDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :phone_numbers, :verified, false
  end
end
