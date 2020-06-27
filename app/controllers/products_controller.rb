class ProductsController < ApplicationController

  def index
    @products = Product.includes(:pictures).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.pictures.new
    @product.build_brand
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :size, :status_id, :delivery_fee_id, :shipping_method_id, :prefecture, :date_of_ship_id, :price, pictures_attributes: [:content], brand_attributes: [:name]).merge(user_id: current_user.id)
  end

end
