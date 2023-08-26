class PostComment < ApplicationRecord

  belongs_to :user
  belongs_to :item

  validates :comment, length: { in: 1..60 }, presence: true

end
