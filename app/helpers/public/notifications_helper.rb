module Public::NotificationsHelper

  def transition_path(notification)
    case  notification.action_type
    when :commented_to_own_post
      item_path(notification.subject.item)
    when :favorited_to_own_post
      item_path(notification.subject.item)
    when :followed_me
      user_path(notification.subject.follower)
    when :chated_to_own_post
      chat_path(notification.subject.user)
    end
  end
end

