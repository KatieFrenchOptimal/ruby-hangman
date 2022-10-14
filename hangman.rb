#!/usr/bin/env ruby

require "./game_view"

class Hangman
  attr_reader :lives
  attr_reader :secret_word
  attr_reader :board
  attr_reader :guessed_letters

  def initialize(input: $stdin, output: $stdout, secret_word: nil)
    @gameview = Gameview.new(output)
    @output = output
    @input = input
    @lives = 9
    @secret_word = secret_word.upcase || File.readlines("words.txt").sample.upcase.chop
    @board = setup_board
    @guessed_letters = []
  end

  def setup_board
    board = ["_"] * secret_word.size
  end

  def start
    while lives > 0 && !won?
      @output.puts board_state
      guess = make_guess
      valid_guess(guess)
      show_past_guesses
    end

    if won?
      @gameview.won
    else
      @gameview.lost(secret_word)
    end
  end

  def game_in_progress?
    lives > 0 && board.include?("_")
  end

  def won?
    board.join("") == secret_word
  end

  def make_guess
    @output.print "Guess a letter: "
    @input.gets.chomp.upcase
  end

  def valid_guess(guess)
    unless guess =~ /^[a-zA-Z]$/
      @output.puts "------------------------------------------------------------------------"
      @output.puts "Input is invalid - please provide a letter."
      @output.puts "------------------------------------------------------------------------"
    else
      save_guess(guess)
    end
  end

  def save_guess(guess)
    if guessed_letters.include?(guess)
      @output.puts "------------------------------------------------------------------------"
      @output.puts "You have already guessed this letter - try again."
      @output.puts "------------------------------------------------------------------------"
    else
      @guessed_letters.push(guess)
      update_board(guess)
    end
  end

  def show_past_guesses
    @output.puts "Your guesses: '#{guessed_letters.join("', '")}'"
  end

  def board_state
    @output.puts "Guess the hidden word: #{board.join(" ")}"
  end

  def update_board(guess)
    if secret_word.include?(guess)
      @output.puts "------------------------------------------------------------------------"
      @output.puts "Correct guess. The letter #{guess} is in the word."
      @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left."

      secret_word.chars.each_with_index do |character, index|
        board[index] = character if character == guess
      end
    else
      @lives -= 1
      @output.puts "------------------------------------------------------------------------"
      @output.puts "The secret word does not include the letter '#{guess}'."
      @output.puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
    end
  end
end
