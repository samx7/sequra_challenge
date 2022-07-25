class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :email
      t.string :cif, null: false

      t.timestamps
      t.index ["cif"], name: "index_users_on_cif", unique: true
    end
  end
end
