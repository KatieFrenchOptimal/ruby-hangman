class Board
  def initialize(output)
    @output = output
  end

  def board_state(board)
    @output.puts "Guess the hidden word: #{board.join(" ")}"
  end
end
