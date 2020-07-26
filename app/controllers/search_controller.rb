class SearchController < ApplicationController
  def index
    # binding.pry
    @q = Product.ransack(params[:q])
    @category_parents = Category.all.order("id ASC").limit(13)
    @category = Category.find_by(id: params["q"]["category_id"])

    @grandchildren = []
    if !@category.nil? && (@category.children != []) && (@category.children[0].children != [])
      @children = @category.children
      @children.each do |child|
        child.children.each do |grandchild|
          @grandchildren << grandchild[:id]
        end
      end
    elsif !@category.nil? && (@category.children != [])
      @category.children.each do |grandchild|
        @grandchildren << grandchild[:id]
      end
    elsif !@category.nil?
      @grandchildren << @category[:id]
    end

    @productsRansack = @q.result(distinct: true)
    if @grandchildren == []
      @products = @productsRansack
    else
      @products = []
      @productsRansack.each do |product|
        if @grandchildren.include?(product[:category_id])
          @products << product
        end
      end
    end
  end
end
