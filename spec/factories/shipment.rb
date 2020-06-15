FactoryBot.define do

  factory :shipment do
    family_name           {"猫"}
    given_name            {"太郎"}
    family_name_kana      {"ネコ"}
    given_name_kana       {"タロウ"}
    postal_code           {"100-0000"}
    prefecture            {"東京都"}
    city                  {"千代田区"}
    house_number          {"1-1"}
    building_name         {""}
    room_number           {""}
    phone_number          {""}
  end

end