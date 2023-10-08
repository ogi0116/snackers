class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    @unchecked_notifications = @notifications.where(checked: false).order(created_at: :desc)
    @checked_notifications = @notifications.where(checked: true).order(created_at: :desc)
  end

   def checked
     # 通知を確認済みに更新
      @notification = Notification.find(params[:id])
      @notification.update(checked: true)
      redirect_to notifications_path
   end

  def destroy_all
    notifications = current_user.notifications
    checked_notifications = notifications.where(checked: true)
    checked_notifications.destroy_all
    redirect_to notifications_path
  end

end
