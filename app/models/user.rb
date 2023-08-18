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
 has_one_attached :profile_image


  enum position_status: { "一般": 0, "企業": 1 }
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
