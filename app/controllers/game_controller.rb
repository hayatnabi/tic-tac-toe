class GameController < ApplicationController
  before_action :init_game, only: [:new, :move]

  def new
    # Just renders the view with current game state

    # Always reset game when visiting new
    if session[:game_over]
      @board = session[:board]
      @current_player = session[:player]
      @name = session[:player] == "P" ? "Pakistan" : "India"
      if session[:player] == "P"
        @message = winner?(session[:player]) ? "#{@name} won!" : "It's a tie!"
      else
        @message = winner?(session[:player]) ? "#{@name} looser!\nRAFAILED Haha" : "It's a tie!"
      end
    else
      init_game
    end
  end

  def reset
    session[:board] = nil
    session[:player] = nil
    session[:game_over] = nil
    redirect_to game_path
  end

  def move
    index = params[:cell].to_i
    return redirect_to game_path if @game_over || @board[index].present?

    @board[index] = current_player
    session[:board] = @board

    if winner?(current_player)
      @message = "Player #{current_player} wins!"
      session[:game_over] = true
    elsif draw?
      @message = "It's a tie!"
      session[:game_over] = true
    else
      session[:player] = switch_player
    end

    redirect_to game_path
  end

  private

  def init_game
    session[:board] ||= Array.new(9)
    session[:player] ||= "I"
    session[:game_over] ||= false

    @board = session[:board]
    @current_player = session[:player]
    @game_over = session[:game_over]
  end

  def current_player
    session[:player]
  end

  def switch_player
    current_player == "P" ? "I" : "P"
  end

  def winner?(player)
    wins = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], # rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], # cols
      [0, 4, 8], [2, 4, 6],           # diags
    ]
    wins.any? { |line| line.all? { |i| @board[i] == player } }
  end

  def draw?
    @board.all?
  end
end
