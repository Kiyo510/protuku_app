class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
