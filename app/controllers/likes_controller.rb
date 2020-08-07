class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @like.save
  end

  def destroy
    @like = Like.find_by(user_id: params[:id])
    # binding.pry
    @like.destroy
  end

  private

  def like_params
    params.permit(:product_id).merge(user_id: current_user.id)
  end
end
