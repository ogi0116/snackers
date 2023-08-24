class Public::ProductsController < ApplicationController
   before_action :authenticate_user!


  def new
     @user = User.find(params[:user_id])
     @product = Product.new
  end

  def index
    @user = User.find(params[:user_id])
    @products = @user.products
    @products = @user.products.page(params[:page])
    @reviews = Review.all
  end

  def create
    @product = Product.new(product_params)
    @user = User.find(params[:user_id])
    @product.user_id = @user.id
    if @product.save
     flash[:notice] = "商品を登録しました"
     redirect_to user_products_path(@user)
    else
      flash[:alert] = "正しい内容を入力してください"
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews.includes(:user)
    @all_rating = '総合評価'
  end

  def edit
     @user = User.find(params[:user_id])
     @product = Product.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
    if current_user == @user
      @product.update(product_params)
      redirect_to user_product_path(@user)
    else
      render "edit"
      flash[:alert] = "更新に失敗しました"
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to user_products_path(@user)
  end

   private

   def product_params
     params.require(:product).permit(:name, :introduction, :price, :image, :active_status, :genre_id ,:user_id)
   end

end
