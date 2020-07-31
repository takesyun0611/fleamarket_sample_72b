class LikesController < ApplicationController

  def create
    # binding.pry
    @like = Like.new(like_params)
    @like.save
  end

  def destroy
  end

  private

  def like_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end
