class Message < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2000 }
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
end
