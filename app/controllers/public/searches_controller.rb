class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      @users = User.page(params[:page])
    else
      @items = Item.looks(params[:search], params[:word])
      @items = Item.page(params[:page])
    end
  end

end


