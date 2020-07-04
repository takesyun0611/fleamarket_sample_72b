require 'rails_helper'
describe Product do
  describe '#create' do
    it "出品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、配送の方法、発送元の地域、発送までの日数、商品の価格¥300~¥9,999,999が存在すれば登録できること" do
      product = build(:product)
      expect(product).to be_valid
    end
    
    it "商品名がないと登録できないこと" do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "商品の説明がないと登録できないこと" do
      product = build(:product, description: "")
      product.valid?
      expect(product.errors[:description]).to include("を入力してください")
    end

    it "カテゴリーを入力しないと登録できないこと" do
      product = build(:product, category_id: "")
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end

    it "商品の状態を入力しないと登録できないこと" do
      product = build(:product, status_id: "")
      product.valid?
      expect(product.errors[:status_id]).to include("を入力してください")
    end

    it "配送料の負担を入力しないと登録できないこと" do
      product = build(:product, delivery_fee_id: "")
      product.valid?
      expect(product.errors[:delivery_fee_id]).to include("を入力してください")
    end

    it "配送の方法を入力しないと登録できないこと" do
      product = build(:product, shipping_method_id: "")
      product.valid?
      expect(product.errors[:shipping_method_id]).to include("を入力してください")
    end

    it "発送元の地域を入力しないと登録できないこと" do
      product = build(:product, prefecture: "")
      product.valid?
      expect(product.errors[:prefecture]).to include("を入力してください")
    end

    it "発送までの日数を入力しないと登録できないこと" do
      product = build(:product, date_of_ship_id: "")
      product.valid?
      expect(product.errors[:date_of_ship_id]).to include("を入力してください")
    end

    it "商品の価格を¥300~¥9,999,999で入力しないと登録できないこと" do
      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("で入力してください")
    end
  end
end