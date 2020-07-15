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

  def searchChild
    @children = Category.find(params[:id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :brand_id, :status_id, :delivery_fee_id, :shipping_method_id, :prefecture, :date_of_ship_id, :price, :sold_out, pictures_attributes: [:content, :_destroy, :id], brand_attributes: [:name]).merge(user_id: current_user.id)
  end

end