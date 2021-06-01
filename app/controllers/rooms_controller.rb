class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_entities

  def index
    #@rooms = Room.all
    @rooms = Room.where(room_users: RoomUser.where(user_id: current_user.id))
  end

  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      @room_user = @room.room_users.build(user_id: current_user.id, room_id: @room.id)
      @room_user.save
      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  protected

  def load_entities
    @rooms = Room.where(room_users: RoomUser.where(user_id: current_user.id))
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
