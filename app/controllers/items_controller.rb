class ItemsController < ApplicationController
  def index
    @products = Product.includes(:pictures).order('created_at DESC')
  end
end
