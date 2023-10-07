class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :message, length: { in: 1..140 }, presence: true


private

  def create_notifications
    # 1. チャットが属する部屋を取得
    room = self.room
    # 2. チャットが属する部屋の中で、自分以外のユーザーを取得
    other_users = room.users.where.not(id: self.user.id)
    # 3. 最初の相手ユーザーを取得
    recipient_user = other_users.first
    # 4. 相手ユーザーに通知を作成
    Notification.create!(subject: self, user: recipient_user, action_type: :chated_to_own_post)
  end
end
