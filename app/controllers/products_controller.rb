class ProductsController < ApplicationController
  require 'payjp'
  # before_action :product_params

  def index
  end

  def create
    @product = Product.find(params[:id])
    binding.pry
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    charge = Payjp::Charge.create(
    amount: @product.price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
  end
  private

  def product_params
    params.require(:item).permit(:price).merge(user_id: current_user.id)
  end
end
