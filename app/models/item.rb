class Item < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  #レビューにコメントする機能
  has_many :post_comments, dependent: :destroy
   #閲覧数のカウントする機能
  has_many :view_counts, dependent: :destroy
 #問題のある投稿を管理者へ報告する機能
  has_many :reports, dependent: :destroy
  #favoritesテーブルを介してuserテーブルに関連するUserモデルのコレクションを取得する
  has_many :favorited_users, through: :favorites, source: :user
   #post_commentテーブルを介してuserテーブルに関連するUserモデルのコレクションを取得する
  has_many :commented_users, through: :post_comments, source: :user
  has_one_attached :image
  belongs_to :product

  validates :title, presence: true
  validates :body, length: { in: 1..100 }, presence: true
  validates :company, presence: true
  validates :area, presence: true
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

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

  #報告された投稿の処理結果を表示
  enum status: { waiting: 0, keep: 1, finish: 2 }

  #投稿一覧表示並び替え
  scope :latest, -> { order(created_at: :desc) }
  scope :most_commented, -> { includes(:commented_users)
    .sort_by { |x| x.commented_users.includes(:post_comments).size }.reverse }
  scope :most_favorited, -> { includes(:favorited_users)
    .sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse }

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

