class CreateCardTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :card_transactions do |t|
      t.references :card, foreign_key: true
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps
    end
  end
end
