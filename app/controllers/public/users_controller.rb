class Public::UsersController < ApplicationController
 
 
  def show
    @user = User.find(params[:id])
    @items = @user.items
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
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :is_deleted, :position_status)
  end
  
end
