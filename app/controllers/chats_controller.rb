class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show
    @user = User.find(params[:id])
    #チャット相手の特定
    rooms = current_user.user_rooms.pluck(:room_id)
    #自分(current_user)に紐付くRoomを全て取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    #チャット相手と共通のRoomを持つ中間テーブルがあるか確認

     unless user_rooms.nil?
      @room = user_rooms.room
     else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
end