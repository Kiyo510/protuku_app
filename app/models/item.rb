# frozen_string_literal: true

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user
  has_one_attached :image
  # アソシエーションを設定する
  has_many :stocks, dependent: :destroy
  # 投稿記事が誰にストックされているかを取得できる
  has_many :stock_users, through: :stocks, source: :user
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps, dependent: :destroy

  validates :prefecture_id, presence: true
  validates :title, presence: true, length: { maximum: 35 }
  validates :content, presence: true, length: { maximum: 10_000 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: '対応してないファイル形式です。' },
                    size: { less_than: 5.megabytes,
                            message: '画像サイズは5MB以下にしてください。' }

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

  # 検索メソッド、タイトルと内容をあいまい検索する
  def self.items_serach(search)
    Item.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

  # 入力されたタグをTagsテーブルに保存する
  def save_items(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end

    # Create
    new_tags.each do |new_name|
      item_tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << item_tag
    end
  end

  def create_notification_stock!(current_user)
    # すでにストックされているか検索
    temp = Notification.where(['visitor_id = ? and visited_id = ? and item_id = ? and action = ? ', current_user.id, user_id, id, 'stock'])
    # ストックされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.build(
        item_id: id,
        visited_id: user_id,
        action: 'stock'
      )
      # 自分の投稿に対するストックの場合は、通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end
end
