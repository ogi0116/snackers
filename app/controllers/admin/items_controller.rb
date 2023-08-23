class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @post_comment = PostComment.new
    @user = @item.user
  end
end
