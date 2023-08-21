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

  #adminで投稿数の推移を表示する機能
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
    scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週の投稿数
    scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }  #先週の投稿数

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

