class SearchController < ApplicationController
  def index
    @products = Product.search(params[:keyword])
  end
end
