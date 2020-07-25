class ItemsController < ApplicationController
  def index
    @products = Product.includes(:pictures).order('created_at DESC').limit(10)
    @q = Product.ransack(params[:q])
  end
end
