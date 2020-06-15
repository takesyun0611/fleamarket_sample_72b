class Shipment < ApplicationRecord
  belongs_to :user, optional: true

  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :given_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :given_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref
end
