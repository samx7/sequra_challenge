class CreateShoppers < ActiveRecord::Migration[7.0]
  def change
    create_table :shoppers do |t|
      t.string :name, null: false
      t.string :email, unique: true
      t.string :nif, null: false, unique: true

      t.timestamps
      t.index ["nif"], name: "index_shoppers_on_nif", unique: true
    end
  end
end
