require 'rails_helper'
describe Shipment do
  describe '#create' do
    it "送付先氏名苗字・名前とそれらのふりがな、郵便番号、都道府県、市区町村、番地が存在すれば登録できること" do
      shipment = build(:shipment)
      expect(shipment).to be_valid
    end

    it "送付先氏名に苗字がないと登録できないこと" do
      shipment = build(:shipment, family_name: "")
      shipment.valid?
      expect(shipment.errors[:family_name]).to include("を入力してください")
    end

    it "送付先氏名に名前がないと登録できないこと" do
      shipment = build(:shipment, given_name: "")
      shipment.valid?
      expect(shipment.errors[:given_name]).to include("を入力してください")
    end

    it "送付先氏名のふりがなに苗字がないと登録できないこと" do
      shipment = build(:shipment, family_name_kana: "")
      shipment.valid?
      expect(shipment.errors[:family_name_kana]).to include("を入力してください")
    end

    it "送付先氏名のふりがながに名前がないと登録できないこと" do
      shipment = build(:shipment, given_name_kana: "")
      shipment.valid?
      expect(shipment.errors[:given_name_kana]).to include("を入力してください")
    end

    it "郵便番号がないと登録できないこと" do
      shipment = build(:shipment, postal_code: "")
      shipment.valid?
      expect(shipment.errors[:postal_code]).to include("を入力してください")
    end

    it "都道府県がないと登録できないこと" do
      shipment = build(:shipment, prefecture: "")
      shipment.valid?
      expect(shipment.errors[:prefecture]).to include("を入力してください")
    end

    it "市区町村がないと登録できないこと" do
      shipment = build(:shipment, city: "")
      shipment.valid?
      expect(shipment.errors[:city]).to include("を入力してください")
    end

    it "番地がないと登録できないこと" do
      shipment = build(:shipment, house_number: "")
      shipment.valid?
      expect(shipment.errors[:house_number]).to include("を入力してください")
    end

    it "マンション名やビル名がなくでも登録できること" do
      shipment = build(:shipment, building_name: "")
      shipment.valid?
      expect(shipment).to be_valid
    end

    it "部屋番号がなくても登録できること" do
      shipment = build(:shipment, room_number: "")
      shipment.valid?
      expect(shipment).to be_valid
    end

    it "お届け先の電話番号がなくても登録できること" do
      shipment = build(:shipment, phone_number: "")
      shipment.valid?
      expect(shipment).to be_valid
    end
  end
end