class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.date :checkin_date
      t.date :checkout_date
      t.integer :number_of_guest
      t.float :service_fee
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
