require 'rails_helper'
describe Picture do
  describe '#create' do
    it "商品画像が1枚以上アップロードされていないと登録できないこと" do
      picture = build(:picture, content: '')
      picture.valid?
      expect(picture.errors[:content]).to include{"をアップロードしてください"}
    end
  end
end