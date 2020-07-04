FactoryBot.define do

  factory :product do
    name                  {"あひる"}
    description           {"あひるのおもちゃ"}
    category_id           {"1"}
    size                  {""}
    brand_id              {""}
    status_id             {"2"}
    delivery_fee_id       {"1"}
    shipping_method_id    {"1"}
    prefecture            {"東京都"}
    date_of_ship_id       {"1"}
    price                 {"999"}

    after(:build) do |product|
      product.pictures << FactoryBot.build(:picture)
    end
  end

end