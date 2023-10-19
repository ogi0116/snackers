class Public::NotificationsController < ApplicationController
  protect_from_forgery

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @unchecked_notifications = @notifications.where(checked: false).order(created_at: :desc)
    @checked_notifications = @notifications.where(checked: true).order(created_at: :desc)
  end

   def checked
     # 通知を確認済みに更新
      @notifications = Notification.all
      @notifications.update(checked: true)
      head :no_content
   end

  def destroy_all
    notifications = current_user.notifications
    checked_notifications = notifications.where(checked: true)
    checked_notifications.destroy_all
    head :no_content
  end

end
