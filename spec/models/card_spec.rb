require 'rails_helper'

describe Card do
  describe '#create' do
    it "customer_idとcard_idが存在して、userと紐付いてるなら登録できること" do
      user = create(:user)
      card = build(:card, user: user)
      expect(card).to be_valid
    end

    it "userと紐付いてないと登録できないこと" do
      user = build(:user) # buildで作成するとuser_idがnilになる
      card = build(:card, user: user)
      card.valid?
      expect(card.errors[:user_id]).to include("を入力してください")
    end

    it "customer_idがなければ登録できないこと" do
      user = create(:user)
      card = build(:card, customer_id: nil, user: user)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idがなければ登録できないこと" do
      user = create(:user)
      card = build(:card, card_id: nil, user: user)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end
  end
end