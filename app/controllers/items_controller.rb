class ItemsController < ApplicationController
  def index
    @products = Product.includes(:pictures).order('created_at DESC').limit(10)
    @q = Product.ransack(params[:q])
    @categorymen = Product.order("RAND()").where('category_id <= 353').where('category_id >= 211').limit(3)
    @categorylady = Product.order("RAND()").where('category_id <= 210').where('category_id >= 14').limit(3)
    @categorybooks = Product.order("RAND()").where('category_id <= 684').where('category_id >= 627').limit(3)
  end
end
