require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネーム、メールアドレス、パスワード、確認用パスワード、ユーザー本名苗字・名前とそれらのふりがな、生年月日が存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ニックネームがないと登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "重複したメールアドレスが存在する場合登録できないこと" do
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスに@がないと登録できないこと" do
      user = build(:user, email: "catgmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "メールアドレスにドメインがないと登録できないこと" do
      user = build(:user, email: "cat@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "パスワードがないと登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは7文字以上でないと登録できないこと" do
      user = build(:user, password: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "確認用パスワードがないと登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "ユーザー本名に苗字がないと登録できないこと" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "ユーザー本名に名前がないと登録できないこと" do
      user = build(:user, given_name: "")
      user.valid?
      expect(user.errors[:given_name]).to include("を入力してください")
    end

    it "ユーザー苗字は全角でないと登録できないこと" do
      user = build(:user, family_name: "neko")
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end

    it "ユーザー名前は全角でないと登録できないこと" do
      user = build(:user, given_name: "tarou")
      user.valid?
      expect(user.errors[:given_name]).to include("は不正な値です")
    end

    it "ユーザー本名ふりがなに苗字がないと登録できないこと" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "ユーザー本名ふりがなに名前がないと登録できないこと" do
      user = build(:user, given_name_kana: "")
      user.valid?
      expect(user.errors[:given_name_kana]).to include("を入力してください")
    end

    it "ユーザー苗字ふりがなが全角でないと登録できないこと" do
      user = build(:user, family_name_kana: "ﾈｺ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "ユーザー名前ふりがなが全角でないと登録できないこと" do
      user = build(:user, given_name_kana: "ﾈｺ")
      user.valid?
      expect(user.errors[:given_name_kana]).to include("は不正な値です")
    end

    it "生年月日がないと登録できないこと" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
  end
end