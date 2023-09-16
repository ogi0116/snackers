class Public::HomesController < ApplicationController
  def top
    @users = User.where(position_status: :company)
    @company_users = @users.sort_by { |user| user.created_at }.reverse.first(5)
  end

  #企業ステータスに設定したユーザーを一覧表示 User.companyでも可能
  def about
    @users = User.where(position_status: :company).order("created_at DESC").page(params[:page])
  end
end