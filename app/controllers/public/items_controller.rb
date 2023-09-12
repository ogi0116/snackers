class Public::ItemsController < ApplicationController
   before_action :authenticate_user!
  def new
    @item = Item.new
    @products = Product.all
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:notice] = "投稿に成功しました"
     redirect_to item_path(@item)
    else
     @items = Item.order("created_at DESC").page(params[:page])
     @user = current_user
     @genres = Genre.all
     @item = Item.new
     @products = Product.all
     flash[:alert] = "投稿に失敗しました"
     render 'index'
    end
  end

  def index
    @products = Product.all
    @items = Item.order("created_at DESC").page(params[:page])
    @user = current_user
    @item = Item.new
    @genres = Genre.all

    if params[:latest]
      @items = Item.latest.page(params[:page])
    elsif params[:most_commented]
      @items = Item.most_commented
      @items = Kaminari.paginate_array(@items).page(params[:page])
    elsif params[:most_favorited]
      @items = Item.most_favorited
      @items = Kaminari.paginate_array(@items).page(params[:page])
    else
      @items = Item.order("created_at DESC").page(params[:page])
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @products = Product.all
    unless ViewCount.find_by(user_id: current_user.id, item_id: @item.id)
      current_user.view_counts.create(item_id: @item.id)
    end
    @new_item = Item.new
    @post_comment = PostComment.new
    @user = @item.user
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to user_path(item.user)
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :title, :body, :company, :area, :image, :star, :product_id, :status)
  end

end
