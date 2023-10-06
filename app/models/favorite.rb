class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :item
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create!(subject: self, user: item.user, action_type: :favorited_to_own_post)
  end
end
