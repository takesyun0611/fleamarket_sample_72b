class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    card = Card.where(user_id: current_user.id).first
    redirect_to user_path(current_user) if card.present?
  end

 # indexアクションはここでは省略

  def create #PayjpとCardのデータベースを作成
    Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
    if params['payjp-token'].blank?
      redirect_to root_path
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録します。
      customer = Payjp::Customer.create(
        description: 'test', # 無くてもOK。PAY.JPの顧客情報に表示する概要です。
        
        # 正規的なメアドでないとエラー出るため、下記一時的コメントアウト
        # email: current_user.email,
        
        card: params['payjp-token'], # 直前のnewアクションで発行され、送られてくるトークンをここで顧客に紐付けて永久保存します。
        metadata: {user_id: current_user.id} # 無くてもOK。
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to user_path(current_user)
      else
        redirect_to new_user_card_path(current_user)
      end
    end
  end

  def show
    @user = User.find(params[:id])
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to action: "new" 
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # カスタマー情報からカードの情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id)

      ##カードのアイコン表示のための定義づけ
      @card_brand = @customer_card.brand
      case @card_brand
      when "Visa"
        # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
        # (画像として登録されている)Visa.pngを返す
        @card_src = "card-icon/visa.png"
      when "JCB"
        @card_src = "card-icon/jcb.png"
      when "MasterCard"
        @card_src = "card-icon/mastercard.png"
      when "American Express"
        @card_src = "card-icon/americanExpress.png"
      when "Diners Club"
        @card_src = "card-icon/dinersClub.png"
      when "Discover"
        @card_src = "card-icon/discover.png"
      end

      #  viewの記述を簡略化
      ## 有効期限'月'を定義
      @exp_month = @customer_card.exp_month.to_s
      ## 有効期限'年'を定義
      @exp_year = @customer_card.exp_year.to_s.slice(2,3)
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end

  def pay #クレジット購入
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
    @product = Product.find(params[:product_id])
    # 購入した際の情報を元に引っ張ってくる
    # テーブル紐付けてるのでログインユーザーのクレジットカードを引っ張ってくる
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
     # キーをセットする(環境変数においても良い)
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: @card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # ↑商品の金額をamountへ、cardの顧客idをcustomerへ、currencyをjpyへ入れる
      @product.update(sold_out: current_user.id)
      flash[:notice] = '購入しました。'
      redirect_to root_path
    end
  end
  
  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
