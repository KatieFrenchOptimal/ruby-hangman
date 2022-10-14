class Gameview
  def initialize(output)
    @output = output
  end

  def won
    @output.puts "You won."
    @output.puts "------------------------------------------------------------------------"
  end

  def lost(secret_word)
    @output.puts "You lost."
    @output.puts "The secret word was: #{secret_word}."
    @output.puts "------------------------------------------------------------------------"
  end
end
