class Shipment < ApplicationRecord
  belongs_to :user, optional: true

  validates :postal_code, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :given_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :given_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
