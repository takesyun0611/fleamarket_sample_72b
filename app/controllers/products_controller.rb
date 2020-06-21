class ProductsController < ApplicationController

  def index
    @products = Product.includes(:pictures).order('created_at DESC')
  end

  def new
    @product = Product.new
    @product.pictures.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def product_params
    params.require(:product).permit(:name, :description, pictures_attributes: [:content])
  end
end
