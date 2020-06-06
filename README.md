# README

## users
|Column|Type|Options|
|------|----|-------|
|email|string|null:false, unique:true|
|password|integer|null:false|
|nickname|string|null:false|
|icon|string|
|family_name|string|null:false|
|given_name|string|null:false|
|family_name_kana|string|null:false|
|given_name_kana|string|null:false|
|birthday|date|null:false|
|phone_number|varchar|
|intro|text|

### Association
- has_many :shipments
- has_many :products
- has_many :orders

## shipments
|Column|Type|Options|
|------|----|-------|
|family_name|string|null:false|
|given_name|string|null:false|
|family_name_kana|string|null:false|
|given_name_kana|string|null:false|
|postal_code|string|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|house_number|string|null:false|
|building_name|string|
|room_number|string|
|phone_number|varchar|
|user_id|integer|foreign_key:true|

### Association
- belongs_to :user

## products
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|description|string|null:false|
|brand_id|string|foreign_key:true|
|status|string|
|delivery_fee|string|null:false|
|delivery_method|string|
|shipping_area|string|prefecture_jp|
|date_of_ship|string|null:false|
|price|integer|null:false|
|user_id|integer|null:false, foreign_key:true|
|category_id|integer|null:false, foreign_key:true|
|amount|integer|null:false|
|size|string|

### Association
- has_many :orders
- has_many :pictures
- belongs_to :user
- belongs_to :category
- belongs_to :brand

## pictures
|Column|Type|Options|
|------|----|-------|
|content|string|null:false|
|products_id|integer|null:false, foreign_key:true|

### Association
- belongs_to :product


## orders
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null:false, foreign_key:true|
|amount|integer|null:false|
|user_id|integer|null:false, foreign_key:true|
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