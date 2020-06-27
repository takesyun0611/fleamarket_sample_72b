class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :shipping_method
  belongs_to :user, optional: true
  belongs_to :category
  belongs_to :brand
  accepts_nested_attributes_for :brand
  has_many :pictures
  accepts_nested_attributes_for :pictures, allow_destroy: true

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref
end
