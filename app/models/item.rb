class Item < ApplicationRecord
   belongs_to :user
   has_one_attached :image
  # アソシエーションを設定する
  has_many :stocks, dependent: :destroy
  # 投稿記事が誰にストックされているかを取得できる
  has_many :stock_users, through: :stocks, source: :user

  validates :title, presence: true, length: { maximum: 35 }
  validates :content, presence: true, length: { maximum: 10000 }


  # 現在ログインしているユーザーidを受け取り、記事をストックする
  def stock(user)
    stocks.create(user_id: user.id)
  end

  # 現在ログインしているユーザーidを受け取り、記事のストックを解除する
  def unstock(user)
    stocks.find_by(user_id: user.id).destroy
  end

  # 記事がストック済みであるかを判定
  # 取得済みであれば true を返す
  def stocked?(user)
    stock_users.include?(user)
  end
end
