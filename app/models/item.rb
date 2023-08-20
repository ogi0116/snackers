class Item < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  #レビューにコメントする機能
  has_many :post_comments, dependent: :destroy
   #閲覧数のカウントする機能
  has_many :view_counts, dependent: :destroy
 #問題のある投稿を管理者へ報告する機能
  has_many :reports, dependent: :destroy
  has_one_attached :image

  #検索方法分岐(検索窓の追加 商品名/会社名)
  def self.looks(search, word)
    if search == "perfect_match"
      @item = Item.where("title LIKE(?) OR company LIKE(?)","#{word}","#{word}")
    elsif search == "forward_match"
      @item = Item.where("title LIKE(?) OR company LIKE(?)","#{word}%","#{word}%")
    elsif search == "backward_match"
      @item = Item.where("title LIKE(?) OR company LIKE(?)","%#{word}","%#{word}")
    elsif search == "partial_match"
      @item = Item.where("title LIKE(?) OR company LIKE(?)","%#{word}%","%#{word}%")
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
  #adminでは商品詳細でいいね機能を使わないため
    def favorited_by?(user)
      favorites.exists?(user_id: user.id)
  end

end

