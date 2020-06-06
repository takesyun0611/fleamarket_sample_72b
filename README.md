# README

## users
|Column|Type|Options|
|------|----|-------|
|email|string|null:false, unique:true|
|password|integer|null:false|
|nickName|string|null:false|
|icon|string|
|familyName|string|null:false|
|givenName|string|null:false|
|familyNameKana|string|null:false|
|givenNameKana|string|null:false|
|birthday|date|null:false|
|phoneNum|string|
|intro|text|

### Association
- has_many :shipments
- has_many :products
- has_many :orders

## shipment
|Column|Type|Options|
|------|----|-------|
|familyName|string|null:false|
|givenName|string|null:false|
|familyNameKana|string|null:false|
|givenNameKana|string|null:false|
|mailAddress|string|
|prefecture|string|
|city|string|
|houseNum|string|
|buildingName|string|
|roomNum|string|
|phoneNum|string|
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
|deliveryFee|string|null:false|
|deliveryMethod|string|
|shippingArea|string|prefecture_jp|
|dateOfShip|string|null:false|
|price|integer|null:false|
|user_id|integer|null:false, foreign_key:true|
|category_id|integer|null:false, foreign_key:true|
|amount|integer|null:false|
|size|string|

### Association
- belongs_to :user
- belongs_to :category
- has_many :orders
- has_many :pictures
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