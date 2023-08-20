class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @items = @user.items.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_root_path
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted, :position_status, :address)
  end

end
