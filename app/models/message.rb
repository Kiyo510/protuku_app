# frozen_string_literal: true

class Message < ApplicationRecord
  validates :content, presence: true, length: { maximum: 2000 }
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  def create_notification_message!(another_user, current_user)
    notification = current_user.active_notifications.build(
      room_id: room_id,
      message_id: id,
      visited_id: another_user.user_id,
      visitor_id: current_user.id,
      action: 'dm'
    )
    # 自分に対するメッセージの場合、通知はこないようにする。
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end
end
