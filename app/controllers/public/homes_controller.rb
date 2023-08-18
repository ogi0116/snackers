class Public::HomesController < ApplicationController
  def top
  end

  #企業ステータスに設定したユーザーを一覧表示
  def about
    @users = User.where('position_status = 1')
    @users = User.page(params[:page])
  end
end
