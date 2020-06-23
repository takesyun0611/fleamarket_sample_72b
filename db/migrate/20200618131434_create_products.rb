class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :size
      t.string :prefecture, null: false
      t.integer :price, null: false
      t.boolean :is_bought, null: false
      t.integer :date_of_ship_id
      t.integer :delivery_fee_burden_id
      t.integer :status_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
