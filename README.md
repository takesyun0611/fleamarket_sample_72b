# README

## users
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false, unique:true|
|encrypted_password|string|null:false, default:""|
|reset_password_token|string|
|icon|string|
|family_name|string|null:false|
|given_name|string|null:false|
|family_name_kana|string|null:false|
|given_name_kana|string|null:false|
|birthday|date|null:false|
|phone_number|string|
|intro|text|
### Association
- has_many :shipments
- has_many :products
- has_many :orders
- has_many :sns_credentials
- has_many :cards
- has_many :likes
- has_many :comments


## shipments
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key:true|
|family_name|string|null:false|
|given_name|string|null:false|
|family_name_kana|string|null:false|
|given_name_kana|string|null:false|
|postal_code|string|null:false|
|prefecture_id|integer|foreign_key:true|
|city|string|null:false|
|house_number|string|null:false|
|building_name|string|
|room_number|string|
|phone_number|string|
### Association
- belongs_to :user
- belongs_to :prefecture


## products
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|description|string|null:false|
|delivery_fee|string|null:false|
|status_id|string|
|shipping_method_id|string|
|date_of_ship_id|string|null:false|
|price|integer|null:false|
|prefecture_id|integer|foreign_key:true|
|size|string|
|user_id|integer|foreign_key:true|
|brand_id|integer|foreign_key:true|
|category_id|integer|foreign_key:true|
|is_bought|boolean|null:false|
### Association
- has_many :orders
- has_many :pictures, dependent: :destroy
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- belongs_to :user
- belongs_to :category
- belongs_to :brand
- belongs_to :status
- belongs_to :shipping_method
- belongs_to :date_of_ship
- belongs_to :prefecture


## pictures
|Column|Type|Options|
|------|----|-------|
|content|string|null:false|
|products_id|integer|foreign_key:true|
### Association
- belongs_to :product


## orders
|Column|Type|Options|
|------|----|-------|
|product_id|integer|foreign_key:true|
|user_id|integer|foreign_key:true|
|rating|integer|
### Association
- belongs_to :user
- belongs_to :product


## categories
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string|null:false|
### Association
- has_many :products


## brands
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
### Association
- has_many :products


## cards
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key:true|
|costomer|string|null:false|
|card_id|string|null:false|
### Association
- belongs_to :user


## sns_credentials
|Column|Type|Options|
|------|----|-------|
|provider|string|
|uid|string|
|user_id|integer|foreign_key:true|
### Association
- belongs_to :user


## likes
|Column|Type|Options|
|------|----|-------|
|user_id|integer|foreign_key:true|
|products_id|integer|foreign_key:true|
### Association
- belongs_to :user
- belongs_to :product


## comments
|Column|Type|Options|
|------|----|-------|
|content|string|null:false|
|product_id|integer|foreign_key:true|
|user_id|integer|foreign_key:true
### Association
- belongs_to :user
- belongs_to :product


## statuses
|Column|Type|Options|
|------|----|-------|
|status|string|null:false|
### Association
- has_many :products


## shipping_methods
|Column|Type|Options|
|------|----|-------|
|method|string|null:false|
### Association
- has_many :products


## date_of_ships
|Column|Type|Options|
|------|----|-------|
|date|string|null:false|
### Association
- has_many :products