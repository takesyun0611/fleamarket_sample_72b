class ProductsController < ApplicationController

  def index
    @products = Product.includes(:pictures).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.pictures.build
    @product.build_brand
    # 下記limitメソッドに親カテゴリの数を代入してくだいさい
    @category_parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @product = Product.new(product_params)
    @category_parents = Category.all.order("id ASC").limit(13)
    if @product.save
      redirect_to product_path(id: @product.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @seller = @product.user
    @category = @product.category
    @comment = @product.comments.new
    @relateProducts = @product.relateProducts(params)
  end


  def edit
    @product = Product.find(params[:id])
    if @product.user == current_user
      render 'edit'
    else
      redirect_to product_path
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(id: @product.id)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to user_path(current_user)
  end

  def searchChild
    @children = Category.find(params[:id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def buy
    @product = Product.find(params[:product_id])
    @shipment = Shipment.find(current_user.id)
    @card = Card.where(user_id: current_user.id).first
    if @card.blank?
      # 未登録なら新規登録画面に
      redirect_to new_user_card_path(current_user)
    else
      # 前前回credentials.yml.encに記載したAPI秘密鍵を呼び出します。
      Payjp.api_key = 'sk_test_94989bc4660d52fba7aa4d1e'
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
    
    if @product.user_id == current_user.id
      redirect_to root_path
    elsif @product.sold_out.present?
      redirect_to root_path
    else
      product_buy_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :brand_id, :status_id, :delivery_fee_id, :shipping_method_id, :prefecture, :date_of_ship_id, :price, :sold_out, pictures_attributes: [:content, :_destroy, :id], brand_attributes: [:name]).merge(user_id: current_user.id)
  end
end