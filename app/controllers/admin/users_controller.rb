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
    if  user.update(user_params)
    redirect_to admin_reports_path
    else
      render "edit"
      flash[:alert]
    end
  end

   protected

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted, :position_status, :address)
  end

end
