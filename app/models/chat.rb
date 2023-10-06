class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates :message, length: { in: 1..140 }, presence: true

def mark_chat_as_read
  chat = Chat.find(params[:chat_id])
  chat.update(read: true)
end

end
