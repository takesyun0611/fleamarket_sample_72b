class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.references :category
      t.string :size
      t.references :brand
      t.references :status
      t.references :delivery_fee
      t.references :shipping_method
      t.string :prefecture
      t.references :date_of_ship
      t.integer :price
      t.boolean :sold_out, default: false, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
