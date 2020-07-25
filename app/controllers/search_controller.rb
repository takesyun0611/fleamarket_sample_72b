class SearchController < ApplicationController
  def index
    # binding.pry
    @q = Product.ransack(params[:q])
    @category_parents = Category.all.order("id ASC").limit(13)
    @products = @q.result(distinct: true)
  end
end
