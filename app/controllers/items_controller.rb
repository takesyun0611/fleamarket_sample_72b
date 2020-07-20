class ItemsController < ApplicationController
  def index
    @products = Product.includes(:pictures).order('created_at DESC')
    @keyword = params.permit(:keyword).to_h
  end
end
