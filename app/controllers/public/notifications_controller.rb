class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc)

  end

  def checked
    notification = current_user.notifications.find(params[:id])
    notification.checked! if notification.checked == false
    redirect_to notification.transition_path
  end

end
