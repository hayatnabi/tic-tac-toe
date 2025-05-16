class GameController < ApplicationController
  before_action :init_board
  before_action :load_game_state

  def new
    # Just renders the view with current game state

    session[:board] ||= Array.new(9)
    session[:current_player] ||= "I"
    session[:game_over] ||= false
    session[:vs_computer] ||= false

    @board = session[:board]
    @current_player = session[:current_player]
    @game_over = session[:game_over]
    @vs_computer = session[:vs_computer]
  end

  def play_with_computer
    session[:board] = Array.new(9)
    session[:game_over] = false
    session[:vs_computer] = true
    session[:current_player] = "I" # Human starts
    redirect_to game_path
  end

  def game
    @board = session[:board]
    @game_over = session[:game_over]
    @vs_computer = session[:vs_computer]
    @current_player = session[:current_player]
  end

  def move
    return redirect_to game_path if session[:game_over]

    index = params[:cell].to_i
    board = session[:board]
    current_player = session[:current_player]

    if board[index].blank?
      board[index] = current_player
      session[:current_player] = toggle_player(current_player)
    end

    winner = check_winner(board)
    if winner || board.all?
      session[:game_over] = true
    end

    # If vs computer and it's computer's turn
    if session[:vs_computer] && !session[:game_over] && session[:current_player] == "P"
      computer_move
    end

    redirect_to game_path
  end

  def reset
    session[:board] = Array.new(9)
    session[:game_over] = false
    session[:vs_computer] = false
    session[:current_player] = "I"
    redirect_to game_path
  end

  private

  def init_board
    session[:board] ||= Array.new(9)
    session[:game_over] ||= false
    session[:vs_computer] ||= false
    session[:current_player] ||= "I"
  end

  def toggle_player(player)
    player == "I" ? "P" : "I"
  end

  def computer_move
    board = session[:board]
    empty_indices = board.each_index.select { |i| board[i].blank? }
    return if empty_indices.empty?

    move = empty_indices.sample
    board[move] = "P"
    session[:current_player] = "I"

    if check_winner(board) || board.all?
      session[:game_over] = true
    end
  end

  def check_winner(board)
    win_combos = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6],
    ]
    win_combos.each do |combo|
      a, b, c = combo
      if board[a].present? && board[a] == board[b] && board[a] == board[c]
        return board[a]
      end
    end
    nil
  end

  private

  def load_game_state
    session[:board] ||= Array.new(9)
    session[:current_player] ||= "I"
    session[:game_over] ||= false
    session[:vs_computer] ||= false

    @board = session[:board]
    @current_player = session[:current_player]
    @game_over = session[:game_over]
    @vs_computer = session[:vs_computer]
  end
end
