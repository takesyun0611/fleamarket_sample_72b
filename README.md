# README

## users
|Column|Type|Options|
|------|----|-------|
|email|string|null:false, unique:true|
|password|integer|null:false|
|nickName|string|null:false|
|credit|string|
|familyName|string|null:false|
|givenName|string|null:false|
|familyNameFurigana|string|null:false|
|givenNameFurigana|string|null:false|
|birthday|date|null:false|
|sendFamilyName|string|
|sendGivenName|string|
|sendFamilyNameHurigana|string|
|sendGivenNameFurigana|string|
|mailAddress|string|
|prefecture|string|
|city|string|
|houseNum|string|
|buildingName|string|
|roomNum|string|
|phoneNum|string|

### Association


## products
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|description|string|null:false|
|brand|string|
|status|string|
|deliveryFee|string|null:false|
|deliveryMethod|string|
|shippingArea|string|
|dateOfShip|string|null:false|
|price|integer|null:false|
|user_id|integer|null:false, foreign_key:true|
|Acategory_id|integer|null:false, foreign_key:true|
|Bcategory_id|integer|null:false, foreign_key:true|
|Ccategory_id|integer|null:false, foreign_key:true|
|number|integer|null:false|

### Association


## pictures
|Column|Type|Options|
|------|----|-------|
|content|string|null:false|
|products_id|integer|null:false, foreign_key:true|

### Association


## orders
|Column|Type|Options|
|------|----|-------|
|product_id|integer|null:false, foreign_key:true|
|num|integer|null:false|
|user_id|integer|null:false, foreign_key:true|
|rating|integer|

### Association


## Acategories
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association


## Bcategories
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|categoryA_id|integer|null:false|

### Association


## Ccategories
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|categoryB_id|integer|null:false|

### Association