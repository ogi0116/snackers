class Public::ProductsController < ApplicationController
   before_action :authenticate_user!
   before_action :ensure_current_user, {only: [:update, :show]}
   before_action :set_current_user, {only: [:edit]}

  def new
     @user = User.find(params[:user_id])
     @product = Product.new
  end

  def index
    @user = User.find(params[:user_id])
    @release_products = @user.products.where(is_secret: true).page(params[:page])
    @secret_products = @user.products.where(is_secret: false)
    @products = @user.products
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
      if params[:is_secret] == "公開中"
        @product.is_secret = true
      elsif params[:is_secret] == "非公開"
        @product.is_secret = false
      else
        @product.update(product_params)
      end

      if @product.save
        redirect_to user_product_path(@user)
        flash[:notice] = "商品の設定を更新しました"
      else
        flash[:alert] = "更新に失敗しました"
        render "edit"
      end
    else
       flash[:alert] = "更新に失敗しました"
      render "edit"
    end
  end

   private

   def product_params
     params.require(:product).permit(:name, :introduction, :price, :image, :active_status, :genre_id ,:user_id, :item_id, :is_secret,)
   end

  def ensure_current_user
     @user = User.find(params[:user_id])
     @product = Product.find(params[:id])
    if @product.is_secret == false && current_user.id != params[:user_id].to_i
       flash[:alert]="閲覧権限がありません"
       redirect_to user_products_path(@user)
    end
  end

  def set_current_user
     @user = User.find(params[:user_id])
     @product = Product.find(params[:id])
    if @product.user != current_user
       flash[:alert]="編集権限がありません"
       redirect_to user_products_path(@user)
    end
  end

end
