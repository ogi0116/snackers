class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


 has_many :items, dependent: :destroy
 has_many :favorites, dependent: :destroy
 #レビューにコメントする機能
 has_many :post_comments, dependent: :destroy
 #閲覧数のカウントする機能
 has_many :view_counts, dependent: :destroy
 has_many :products, dependent: :destroy
 #商品の評価点平均値を表示する機能
 has_many :reviews, dependent: :destroy
 #問題のある投稿を管理者へ報告する機能
  has_many :reports, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :item
 has_one_attached :profile_image

  validates :name,length: { in: 1..10 }, presence: true
  validates :introduction,length: { maximum:100 }
  validates :address,length: { maximum:30 }
  validates :is_deleted, inclusion: { in: [true, false] }
  validates :position_status, presence: true

  #認証マークの付与
  enum certification_status:  { "unachieved": 0, "achieved": 1, "admin": 2 }
  #企業ステータスの場合わけ
  enum position_status: { "normal": 0, "company": 1 }
  #検索機能の日本語化
  enum range: { "User": 0, "Item": 1 }

  #フォロー機能の実装
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  #DM機能の実装
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  #ユーザー名検索機能
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  #adminで新規ユーザー数の推移を表示する機能
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前
    scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週の投稿数
    scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }  #先週の投稿数

  def followed_by?(user)
    # フォローしているかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
