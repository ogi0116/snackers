class Public::ProductsController < ApplicationController

  def new
     @user = User.find(params[:user_id])
     @product = Product.new
  end

  def index
    @user = User.find(params[:user_id])
    @products = @user.products
  end

  def create
    @product = Product.new(product_params)
    @user = User.find(params[:user_id])
    @product.user_id = @user.id
    if @product.save
     redirect_to user_products_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
  end

  def edit
  end

   private

   def product_params
     params.require(:product).permit(:name, :introduction, :price, :image, :active_status, :genre_id ,:user_id)
   end

end
