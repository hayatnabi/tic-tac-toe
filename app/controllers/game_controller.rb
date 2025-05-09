class GameController < ApplicationController
  def new
    # @game = Game.new
  end

  def create
    # @game = Game.new(game_params)
    # if @game.save
    #   redirect_to game_path(@game)
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def show
    # @game = Game.find(params[:id])
  end

  private

  def game_params
    params.require(:game).permit(:player1, :player2)
  end
end
