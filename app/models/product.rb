class Product < ApplicationRecord

  belongs_to :genre
  belongs_to :user
  #商品の評価点平均値を表示する機能
  has_many :reviews, dependent: :destroy
  has_one_attached :image

  #販売ステータスの設定
  enum active_status: { "sale": 0, "limited_time_sale": 1, "end_of_sale":2 }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/potatochips.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
