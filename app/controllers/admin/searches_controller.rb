class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    else
      @items = Item.looks(params[:search], params[:word]).page(params[:page])
    end
  end

end
