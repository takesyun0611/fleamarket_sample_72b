class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :size
      t.string :prefecture, null: false
      t.integer :price
      t.boolean :is_bought
      t.integer :date_of_ship_id
      t.integer :delivery_fee_burden_id
      t.integer :status_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
