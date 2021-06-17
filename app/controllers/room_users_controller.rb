# frozen_string_literal: true

class RoomUsersController < ApplicationController
  before_action :set_room, only: %i[index new create destroy]

  def index
    @room_users = @room.room_users
  end

  def new
    @room_users = @room.room_users
    room_user_ids = []

    @room_users.each do |user|
      room_user_ids << user.user_id
    end

    @users = User.where.not(id: room_user_ids).order(:email)
    @room_user = RoomUser.new
  end

  def create
    @room_user = @room.room_users.build(room_user_params)
    respond_to do |format|
      if @room_user.save
        format.js
        format.html { redirect_to room_path(@room), success: 'The users added to room' }
        format.json
      end
    end
  end

  def destroy
    @room_user = RoomUser.find(params[:id])
    @room_user.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to room_room_users_path(@room), info: 'The user removed!' }
      format.json
    end
  end

  private

  def room_user_params
    params.require(:room_user).permit(:user_id, :room_id)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end
end
