class Public::PostCommentsController < ApplicationController
  
  def create
    item = Item.find(params[:item_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.item_id = item.id
    comment.save
    redirect_to item_path(item)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
