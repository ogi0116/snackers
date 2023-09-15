class Public::HomesController < ApplicationController
  def top
    @random_company1 = User.where(position_status: :company).order("RANDOM()").first
    @random_company2 = User.where(position_status: :company).order("RANDOM()").second
    @random_company3 = User.where(position_status: :company).order("RANDOM()").third
  
  end

  #企業ステータスに設定したユーザーを一覧表示 User.companyでも可能
  def about
    @users = User.where(position_status: :company).order("created_at DESC").page(params[:page])
  end
end