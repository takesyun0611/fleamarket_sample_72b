class ProductsController < ApplicationController

  def index
    @products = Product.includes(:pictures).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.pictures.new
    @product.build_brand

    # 下記limitメソッドに親カテゴリの数を代入してくだいさい
    @category_parents = Category.all.order("id ASC").limit(2)
  end

  def create
    @product = Product.new(product_params)
    @category_parents = Category.all.order("id ASC").limit(2)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def searchChild
    @children = Category.find(params[:id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :status_id, :delivery_fee_id, :shipping_method_id, :prefecture, :date_of_ship_id, :price, :sold_out, pictures_attributes: [:content], brand_attributes: [:name]).merge(user_id: current_user.id)
  end

end
