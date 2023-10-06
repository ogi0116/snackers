module Public::NotificationsHelper

  def transition_path(notification)
    case  notification.action_type.to_sym
    when :commented_to_own_post
      item_path( notification.subject.item, anchor: "js-comment-#{ notification.subject.id}")
    when :favorited_to_own_post
      item_path( notification.subject.item, anchor: "js-favorite-#{ notification.subject.id}")
    when :followed_me
      user_path( notification.subject.follower)
    end
  end

end

