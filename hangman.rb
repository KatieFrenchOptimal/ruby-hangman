#!/usr/bin/env ruby

class Hangman
  attr_reader :lives
  attr_reader :secret_word
  attr_reader :board
  attr_reader :guessed_letters

  def initialize
    @lives = 9
    @secret_word = File.readlines("words.txt").sample.upcase.chop
    @board = setup_board
    @guessed_letters = []
  end

  def setup_board
    board = ["_"] * secret_word.size
  end

  def start
    while lives > 0 && !won?
      puts board_state
      guess = make_guess
      valid_guess(guess)
      show_past_guesses
    end

    if won?
      puts "You won."
      puts "------------------------------------------------------------------------"
    else
      puts "You lost."
      puts "The secret word was: #{secret_word}."
      puts "------------------------------------------------------------------------"
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

  def valid_guess(guess)
    unless guess =~ /^[a-zA-Z]$/
      puts "------------------------------------------------------------------------"
      puts "Input is invalid - please provide a letter."
      puts "------------------------------------------------------------------------"
    else
      save_guess(guess)
    end
  end

  def save_guess(guess)
    if guessed_letters.include?(guess)
      puts "------------------------------------------------------------------------"
      puts "You have already guessed this letter - try again."
      puts "------------------------------------------------------------------------"
    else
      @guessed_letters.push(guess)
      update_board(guess)
    end
  end

  def show_past_guesses
    puts "Your guesses: '#{guessed_letters.join("', '")}'"
  end

  def board_state
    puts "Guess the hidden word: #{board.join(" ")}"
  end

  def update_board(guess)
    if secret_word.include?(guess)
      puts "------------------------------------------------------------------------"
      puts "Correct guess. The letter #{guess} is in the word."
      puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left."

      secret_word.chars.each_with_index do |character, index|
        board[index] = character if character == guess
      end
    else
      @lives -= 1
      puts "------------------------------------------------------------------------"
      puts "The secret word does not include the letter '#{guess}'."
      puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
    end
  end
end
