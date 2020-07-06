FactoryBot.define do
  factory :product do
    name                  {"あひる"}
    description           {"あひるのおもちゃ"}
    size                  {""}
    status_id             {"2"}
    delivery_fee_id       {"1"}
    shipping_method_id    {"1"}
    prefecture            {"東京都"}
    date_of_ship_id       {"1"}
    price                 {"999"}
    category_id           {"1"}
    category
    brand
    after(:build) do |product|
      product.pictures << FactoryBot.build(:picture, content: Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/icon_brand.png")))
    end
  end
end
