class GameView
  def initialize(output, input)
    @output = output
    @input = input
  end

  def make_guess
    guess = nil

    loop do
      @output.print "Guess a letter: "
      guess = @input.gets.chomp.upcase

      if guess =~ /^[a-zA-Z]$/
        break
      end

      invalid_guess_message
    end

    guess
  end

  def show_board_state(board, guessed_letters)
    @output.puts "Guess the hidden word: #{board.map{ |char| char.nil? ? '_' : char }.join(" ")}"
    @output.puts "Your guesses: '#{guessed_letters.join("', '")}'"
  end

  def won_message(secret_word)
    @output.puts "You won."
    @output.puts "The secret word was: #{secret_word}."
    @output.puts "------------------------------------------------------------------------"
  end

  def lost_message(secret_word)
    @output.puts "You lost."
    @output.puts "The secret word was: #{secret_word}."
    @output.puts "------------------------------------------------------------------------"
  end

  def invalid_guess_message
    @output.puts "------------------------------------------------------------------------"
    @output.puts "Input is invalid - please provide a letter."
    @output.puts "------------------------------------------------------------------------"
  end

  def repeated_guess_message
    @output.puts "------------------------------------------------------------------------"
    @output.puts "You have already guessed this letter - try again."
    @output.puts "------------------------------------------------------------------------"
  end

  def correct_guess_message(guess, lives)
    @output.puts "------------------------------------------------------------------------"
    @output.puts "Correct guess. The letter '#{guess}' is in the word."
    @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left."
  end

  def incorrect_guess_message(guess, lives)
    @output.puts "------------------------------------------------------------------------"
    @output.puts "The secret word does not include the letter '#{guess}'."
    @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
  end

  def past_guesses(guessed_letters)
    @output.puts "Your guesses: '#{guessed_letters.join("', '")}'"
  end
end
