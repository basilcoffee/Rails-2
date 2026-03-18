class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = @room.reservations.new
  end

  def search
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR introduction LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :introduction, :price, :address, :image)
  end
end
