class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name, null: false
      t.string :email, unique: true
      t.string :cif, null: false, unique: true

      t.timestamps
      t.index ["cif"], name: "index_users_on_cif", unique: true
    end
  end
end
