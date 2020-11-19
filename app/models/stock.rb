# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :item
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :item_id, presence: true

  def self.get_stock_items(user)
    where(user_id: user.id).map(&:item)
  end
end
