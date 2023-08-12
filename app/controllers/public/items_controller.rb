class Public::ItemsController < ApplicationController
  def new
    item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
     redirect_to items_path, notice: "You have created tweet successfully."
    else
     @items = Item.all
     @user = current_user
     render 'index'
    end
  end

  def index
    @items = Item.all
    @user = current_user
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
    @new_item = Item.new
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  private

  def tweet_params
    params.require(:item).permit(:name, :body, :image)
  end

end
