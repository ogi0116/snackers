class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates :comment, length: { in: 1..60 }, presence: true

  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications


  private

  def create_notifications
    Notification.create!(subject: self, user: item.user, action_type: :commented_to_own_post)
  end
end
