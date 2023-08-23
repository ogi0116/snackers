class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @users = User.all
    @today_user =  @users.created_today
    @yesterday_user = @users.created_yesterday
    @this_week_user = @users.created_this_week
    @last_week_user = @users.created_last_week

    @items = Item.all
    @today_item =  @items.created_today
    @yesterday_item = @items.created_yesterday
    @this_week_item = @items.created_this_week
    @last_week_item = @items.created_last_week
  end
end
