class Public::HomesController < ApplicationController
  def top
    @users = User.where(position_status: :company)
    @company_users = @users.sort_by { |user| user.created_at }.reverse.first(5)
  end

  #企業ステータスに設定したユーザーを一覧表示 User.companyでも可能
  def about
    @users = User.where(position_status: :company).order("created_at DESC").page(params[:page])
    @notifications = current_user.notifications.order(created_at: :desc)
    @unchecked_notifications = @notifications.where(checked: false).order(created_at: :desc)
    @checked_notifications = @notifications.where(checked: true).order(created_at: :desc)
  end
end