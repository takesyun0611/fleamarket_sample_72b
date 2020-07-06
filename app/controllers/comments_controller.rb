class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to product_path(id: params[:product_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end
