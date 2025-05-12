class GamesController < ApplicationController
  def new
    # Initialize a new game or reset the game state
    @game = Game.new

    session[:board] ||= Array.new(3) { Array.new(3, "") } # 3x3 board
    session[:current_player] ||= "X" # Player X starts
    @board = session[:board]
    @current_player = session[:current_player]
  end

  def create
    @game = Game.find_or_create_by(id: params[:id])
    move = params[:move]
    if move
      row, col = move.split(",")
      @game.play_move(row.to_i, col.to_i)
      redirect_to game_path(@game)
    end
  end

  def restart
    session[:board] = Array.new(3) { Array.new(3, "") }
    session[:current_player] = "X"
    redirect_to action: :index
  end

  def make_move
    row_idx = params[:row].to_i
    col_idx = params[:col].to_i
    player = session[:current_player]

    # Make move if the cell is empty
    if session[:board][row_idx][col_idx].empty?
      session[:board][row_idx][col_idx] = player
      # Switch player
      session[:current_player] = (player == "X" ? "O" : "X")
    end

    # Check for winner
    if winner?(player)
      flash[:notice] = "#{player} wins!"
    end

    redirect_to action: :index
  end

  private

  # Check for a winner
  def winner?(player)
    # Check rows, columns, and diagonals for a winner
    board = session[:board]

    # Check rows
    (0..2).any? { |r| board[r].all? { |cell| cell == player } } ||
      # Check columns
    (0..2).any? { |c| board.all? { |row| row[c] == player } } ||
      # Check diagonals
    [0, 2].all? { |i| board[i][i] == player } ||
    [0, 2].all? { |i| board[i][2 - i] == player }
  end
end
