class Tagmap < ApplicationRecord
  belongs_to :item
  belongs_to :tag
  validates :item_id, presence: true
  validates :tag_id, presence: true
end
