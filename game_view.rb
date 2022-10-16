class Gameview
  def initialize(output)
    @output = output
  end

  def won(secret_word)
    @output.puts "You won."
    @output.puts "The secret word was: #{secret_word}."
    @output.puts "------------------------------------------------------------------------"
  end

  def lost(secret_word)
    @output.puts "You lost."
    @output.puts "The secret word was: #{secret_word}."
    @output.puts "------------------------------------------------------------------------"
  end

  def invalid_guess
    @output.puts "------------------------------------------------------------------------"
    @output.puts "Input is invalid - please provide a letter."
    @output.puts "------------------------------------------------------------------------"
  end

  def repeated_guess
    @output.puts "------------------------------------------------------------------------"
    @output.puts "You have already guessed this letter - try again."
    @output.puts "------------------------------------------------------------------------"
  end

  def correct_guess(guess, lives)
    @output.puts "------------------------------------------------------------------------"
    @output.puts "Correct guess. The letter '#{guess}' is in the word."
    @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left."
  end

  def incorrect_guess(guess, lives)
    @output.puts "------------------------------------------------------------------------"
    @output.puts "The secret word does not include the letter '#{guess}'."
    @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
  end

  def past_guesses(guessed_letters)
    @output.puts "Your guesses: '#{guessed_letters.join("', '")}'"
  end
end
