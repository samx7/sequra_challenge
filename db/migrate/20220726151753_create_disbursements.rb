class CreateDisbursements < ActiveRecord::Migration[7.0]
  def change
    create_table :disbursements do |t|
      t.datetime :date, null: false
      t.integer :merchant_id, null: false
      t.decimal :amount

      t.timestamps
    end
  end
end
