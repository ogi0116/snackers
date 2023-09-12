class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_back fallback_location: root_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to admin_reports_path
  end

  private

  def item_params
    params.require(:item).permit(:status)
  end
end
