class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :delivery_fee 
      t.string :status_id
      t.string :shipping_method_id
      t.string :date_of_ship_id
      t.integer :price
      t.integer :prefecture_id, foreign_key: true
      t.string :size
      t.integer :user_id, foreign_key: true
      t.integer :brand_id, foreign_key: true
      t.integer :category_id, foreign_key: true
      t.boolean :is_bought
      t.timestamps
    end
  end
end
