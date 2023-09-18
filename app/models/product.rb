class Product < ApplicationRecord

  belongs_to :genre
  belongs_to :user
  #商品の評価点平均値を表示する機能
  has_many :reviews, dependent: :destroy
  has_one_attached :image
  #belongs_to :item, optional: true

  validates :name, presence: true
  validates :introduction, length: { in: 1..140 }, presence: true
  validates :price, presence: true
  validates :active_status, presence: true
  validates :image,presence: true
  validates :is_secret, inclusion: { in: [true, false] }


  #販売ステータスの設定
  enum active_status: { "sale": 0, "limited_time_sale": 1, "end_of_sale":2 }
  #商品の評価を1人1回に設定
  def reviewed_by?(user)
    reviews.exists?(user_id: user.id)
  end

  #ユーザーが画像を選択するときに使用するセレクトボックス内容
  def product_display
    user.name + ':' + name
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/potatochips.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
