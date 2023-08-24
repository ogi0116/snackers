class Public::PostCommentsController < ApplicationController
   before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @user = @item.user
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.item_id = @item.id
    @post_comment.save
    #redirect_to item_path(item) 非同期化
  end

  def destroy
    @post_comment = PostComment.find(params[:id]).destroy
    @post_comment.destroy
    @item = Item.find(params[:item_id])
   # redirect_to request.referer 非同期化
  end



  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
