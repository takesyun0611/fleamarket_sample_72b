class ItemsController < ApplicationController
  def index
    @products = Product.includes(:pictures).order('created_at DESC').limit(10)
    @keyword = params.permit(:keyword).to_h
  end
end
