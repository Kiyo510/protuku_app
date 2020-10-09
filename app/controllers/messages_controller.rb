class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @room = @message.room
    if @message.save
      @room_member_not_me = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid = @room_member_not_me.find_by(room_id: @room.id)
      notification = current_user.active_notifications.build(
        room_id: @room.id,
        message_id: @message.id,
        visited_id: @theid.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )
      # 自分に対するメッセージの場合、通知はこないようにする。
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
      redirect_to room_path(@message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    flash[:success] = 'メッセージを削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :content)
  end
end
