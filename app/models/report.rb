class Report < ApplicationRecord

  #管理者へ問題のある投稿を報告する機能、ユーザーとアイテムの中間テーブル
  belongs_to :user
  belongs_to :item

  validates :report, length: { in: 1..100 }, presence: true

end
