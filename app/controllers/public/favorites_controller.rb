class Public::FavoritesController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.new(item_id: @item.id)
    favorite.save
    #redirect_back fallback_location: root_path 非同期化
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.find_by(item_id: @item.id)
    favorite.destroy
    #redirect_back fallback_location: root_path　非同期化
  end

end
