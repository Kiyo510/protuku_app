module SetRoom
  extend ActiveSupport::Concern

  def set_room
    @current_entry.each do |current|
      @another_entry.each do |another|
        # ルームが存在する場合
        if current.room_id == another.room_id
          @is_room = true
          @room_id = current.room_id
        end
      end
    end
    # ルームが存在しない場合は新規作成
    unless @is_room
      @room = Room.new
      @entry = Entry.new
    end
  end
end
