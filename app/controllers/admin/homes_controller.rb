class Admin::HomesController < ApplicationController

  def top
    @users = User.all
    @today_user =  @users.created_today
    @yesterday_user = @users.created_yesterday
    @this_week_user = @users.created_this_week
    @last_week_user = @users.created_last_week
  end
end
