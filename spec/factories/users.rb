FactoryBot.define do

  factory :user do
    nickname              {"abc"}
    email                 {"cat@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"猫"}
    given_name            {"太郎"}
    family_name_kana      {"ネコ"}
    given_name_kana       {"タロウ"}
    birthday              {"2020-1-1"}
    phone_number          {""}
    intro                 {""}
  end

end