# frozen_string_literal: true

class User < ApplicationRecord
  require 'open-uri'
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save   :downcase_email, unless: :uid?
  before_create :create_activation_digest

  has_many :stocks, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_one_attached :avatar

  validates :avatar, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: '対応してないファイル形式です。' },
                     size: { less_than: 5.megabytes,
                             message: '画像サイズは5MB以下にしてください。' }
  validates :nickname, presence: true, unless: :uid?, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, unless: :uid?, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :introduction, length: { maximum: 2000 }
  validates :accepted, acceptance: { message: 'をチェックしてください' }, on: :create

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # アカウントを有効にする
  def activate!
    update(activated: true, activated_at: Time.zone.now)
  end

  def accepts_terms!
    update(accepted: true)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 3.hours.ago
  end

  # twitter認証
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    email = User.dummy_email(auth)
    password = SecureRandom.urlsafe_base64
    # Twitterのオリジナルサイズのプロフィール画像パスを取得
    profile_image_url = auth.info.image.gsub('_normal', '')

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.email = email
      user.password = password
      user.download_and_attach_avatar(profile_image_url)
    end
  end

  # twitterAPIで取得した画像データをopen-uriでダウンロードし、IOインスタンスを直接アタッチする
  def download_and_attach_avatar(profile_image_url)
    return unless profile_image_url

    file = URI.open(profile_image_url)
    avatar.attach(io: file,
                  filename: "profile_image.#{file.content_type_parse.first.split('/').last}",
                  content_type: file.content_type_parse.first)
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
