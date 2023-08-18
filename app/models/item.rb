class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  #レビューにコメントする機能
  has_many :post_comments, dependent: :destroy
   #閲覧数のカウントする機能
  has_many :view_counts, dependent: :destroy

  #商品名e検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @item = Item.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("title LIKE?","%#{word}%")
    else
      @item = Item.all
    end
  end

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

