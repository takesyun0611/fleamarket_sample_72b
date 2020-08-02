class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def show_list_product
    @user = User.find(current_user.id)
  end
end
