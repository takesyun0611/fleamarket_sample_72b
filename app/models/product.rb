class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to :brand
  belongs_to :category
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  belongs_to_active_hash :date_of_ship
  belongs_to_active_hash :delivery_fee_burden
  belongs_to_active_hash :status

  validates :picture, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :status, presence: true
  validates :shipping_fee_burden, presence: true
  validates :shipping_method, presence: true
  validates :prefecture, presence: true
  validates :date_of_ship, presence: true
  validates :price, presence: true

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref
end
