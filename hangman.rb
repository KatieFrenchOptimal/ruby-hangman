#!/usr/bin/env ruby

# lives = 9
# guessed_letters = []
# secret_word = File.readlines("words.txt").sample.upcase.chop
# board =  ["_"] * secret_word.size

# while lives > 0 && board.include?("_")
#   puts "Try to guess this hidden word: #{board.join(" ")}"
#   print "Guess a letter: "

#   guess = gets.chomp.upcase

#   if guessed_letters.include?(guess)
#     puts "------------------------------------------------------------------------"
#     puts "You have already guessed this letter - try again."
#     puts "------------------------------------------------------------------------"
#     next
#   end

#   unless guess =~ /^[a-zA-Z]$/
#     puts "------------------------------------------------------------------------"
#     puts "Input is invalid - please provide a letter."
#     puts "------------------------------------------------------------------------"
#     next
#   end

#   if secret_word.include?(guess)
#     puts "------------------------------------------------------------------------"
#     puts "Correct guess. The letter #{guess} is in the word."
#     puts "You have #{lives > 1 ? 'lives' : 'life'} remaining lives left."

#     secret_word.chars.each_with_index do |character, index|
#       board[index] = character if character == guess
#     end
#   else
#     lives -= 1
#     puts "------------------------------------------------------------------------"
#     puts "The secret word does not include the letter '#{guess}'."
#     puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
#   end

#   guessed_letters.push(guess)
#   puts "Your guesses: '#{guessed_letters.join("', '")}'"
# end

# if board.join("") == secret_word
#   puts "You won."
#   puts "------------------------------------------------------------------------"
# elsif lives <= 0
#   puts "You lost."
#   puts "The secret word was: #{secret_word}."
#   puts "------------------------------------------------------------------------"
# end

class Hangman
  attr_reader :lives
  attr_reader :secret_word
  attr_reader :board

  def initialize
    @lives = 9
    @secret_word = File.readlines("words.txt").sample.upcase.chop
    @board = setup_board
  end

  def setup_board
    board = ["_"] * secret_word.size
  end

  def start
    puts "welcome"
    puts secret_word

    # while game in progress
    while lives > 0 && !won?
      # print number of lives
      puts "You have #{lives} remaining lives left."
      # print the board state
      puts board_state
      # recieve a guess
      guess = make_guess
      # update the board
      update_board(guess)
    end

    if won?
      puts "you won"
    else
      puts "you lost"
    end
  end

  def game_in_progress?
    lives > 0 && board.include?("_")
  end

  def won?
    board.join("") == secret_word
  end

  def make_guess
    print "Guess a letter: "
    gets.chomp.upcase
  end

  def board_state
    board.join(" ")
  end

  def update_board(guess)
    if secret_word.include?(guess)
      secret_word.chars.each_with_index do |character, index|
        board[index] = character if character == guess
      end
    else
      @lives -= 1
    end
  end
end

game = Hangman.new
game.start


# could have another class for the board how it updates/reanders/loooks after setup
