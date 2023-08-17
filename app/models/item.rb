class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  #レビューにコメントする機能
  has_many :post_comments, dependent: :destroy
   #閲覧数のカウントする機能
  has_many :read_counts, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/potatochips.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end

