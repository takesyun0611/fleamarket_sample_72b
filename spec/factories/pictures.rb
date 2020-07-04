FactoryBot.define do
  factory :picture do
    content  { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/icon_brand.png")) }
  end
end
