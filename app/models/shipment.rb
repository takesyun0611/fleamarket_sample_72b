class Shipment < ApplicationRecord
  belongs_to :user
  belongs_to :prefecture

  [family_name, given_name, family_name_kana, given_name_kana, postal_code, city, house_number].each do |v|
    validates v,
      presence: true
  end
end
