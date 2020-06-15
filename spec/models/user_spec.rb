require 'rails_helper'
describe User do
  describe '#create' do
    it "ニックネームが必須" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "メールアドレスは一意である" do
      #はじめにユーザーを登録
      user = create(:user)
      #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスは@を含む必要がある" do
      user = build(:user, email: "catgmail.com")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "メールアドレスはドメインを含む必要がある" do
      user = build(:user, email: "cat@")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "パスワードが必須" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは7文字以上" do
      user = build(:user, password: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "パスワードは確認用を含めて2回入力する" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "ユーザー本名が、苗字必須" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it "ユーザー本名が、名前必須" do
      user = build(:user, given_name: "")
      user.valid?
      expect(user.errors[:given_name]).to include("を入力してください")
    end

    it "ユーザー苗字は全角で入力させる" do
      user = build(:user, family_name: "neko")
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end

    it "ユーザー名前は全角で入力させる" do
      user = build(:user, given_name: "tarou")
      user.valid?
      expect(user.errors[:given_name]).to include("は不正な値です")
    end

    it "ユーザー本名ふりがなが、苗字必須" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it "ユーザー本名ふりがなが、名前必須" do
      user = build(:user, given_name_kana: "")
      user.valid?
      expect(user.errors[:given_name_kana]).to include("を入力してください")
    end

    it "ユーザー苗字ふりがなは全角で入力させる" do
      user = build(:user, family_name_kana: "ﾈｺ")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は不正な値です")
    end

    it "ユーザー名前ふりがなは全角で入力させる" do
      user = build(:user, given_name_kana: "ﾈｺ")
      user.valid?
      expect(user.errors[:given_name_kana]).to include("は不正な値です")
    end

    it "生年月日が必須" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
  end
end