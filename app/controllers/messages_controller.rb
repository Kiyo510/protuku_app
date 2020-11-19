# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @room = @message.room
    if @message.save
      @room_member_not_me = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @another_user = @room_member_not_me.find_by(room_id: @room.id)
      @message.create_notification_message!(@another_user, current_user)
      flash[:success] = 'メッセージを送信しました'
      redirect_to room_path(@message.room)
    else
      flash[:danger] = 'メッセージの送信に失敗しました'
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
