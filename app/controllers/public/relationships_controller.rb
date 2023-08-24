class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
    #redirect_back fallback_location: root_path 非同期通信化
  end

  def destroy
    @user = User.find(params[:user_id])
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
   # redirect_back fallback_location: root_path 非同期通信化
  end
end
