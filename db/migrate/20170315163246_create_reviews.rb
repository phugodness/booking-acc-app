class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :rank
      t.text :comment

      t.timestamps
    end
  end
end
