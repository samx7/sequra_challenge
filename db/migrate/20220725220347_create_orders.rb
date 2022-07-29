class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :merchant_id, null: false
      t.integer :shopper_id
      t.decimal :amount, null: false
      t.datetime :completed_at

      t.timestamps
    end
  end
end
