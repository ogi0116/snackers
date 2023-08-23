class Public::UsersController < ApplicationController
   before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @genres = Genre.all
    @items = @user.items.page(params[:page])
    @item = Item.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to user_path(user)
  end

  def unscribe
  end

  #reset_session ページ遷移しても以前入力した情報を保持することができる機能を削除する
  def withdrawal
    current_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to '/'
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:item_id)
    @favorite_items = Item.find(favorites)
    #findで取得した値はページ付け可能配列ではない配列（array)として返ってくるため、通常とは違う記述が必要
    @favorite_items = Kaminari.paginate_array(@favorite_items).page(params[:page])

    @item = Item.new
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings.page(params[:page])
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted, :position_status, :address)
  end

  def reject_user
    @user= User.find_by(params[:current_user])
    if @user
      if @user.valid_password?(params[:current_user]) && (@user.is_deleted == false)
        flash[:notice] = "退会済みです。再度登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

end
