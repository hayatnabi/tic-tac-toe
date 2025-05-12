class Game < ApplicationRecord
  after_initialize :set_defaults

  def board
    value = self[:board]
    value.is_a?(String) ? JSON.parse(value) : value
  end

  def board=(val)
    self[:board] = val
  end

  def play_move(row, col)
    current_board = board
    return false if current_board[row][col].present?

    current_board[row][col] = turn
    self.board = current_board
    switch_turn
    save
    true
  end

  private

  def switch_turn
    self.turn = (turn == "X" ? "O" : "X")
  end

  def set_defaults
    self.board ||= [["", "", ""], ["", "", ""], ["", "", ""]]
    self.turn ||= "X"
  end
end
