class CreateShipments < ActiveRecord::Migration[5.2]
  def change
    create_table :shipments do |t|
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :postal_code, null: false
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :building_name
      t.string :room_number
      t.string :phone_number
      t.references :users, foreign_key: true
      t.references :prefectures, foreign_key: true
      t.timestamps
    end
  end
end
