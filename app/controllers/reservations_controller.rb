class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room)
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.invalid?
      render "rooms/show"
    end
  end

  def create
    @room = Room.find(params[:room_id])

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room = @room

    if @reservation.save
      redirect_to rooms_path, notice: "予約しました"
    else
       @room = Room.find(params[:room_id])
       @reservation = current_user.reservations.build(reservation_params)
      render "rooms/show"
    end
  end


  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :people)
  end
end

