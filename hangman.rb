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
    @secret_word = secret_word || File.readlines("words.txt").sample.upcase.chop
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

      unless valid_guess(guess)
        @gameview.invalid_guess
      else
        save_guess(guess)
      end

      @gameview.past_guesses(guessed_letters)
    end

    if won?
      @gameview.won(secret_word)
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
    guess =~ /^[a-zA-Z]$/
  end

  def save_guess(guess)
    if guessed_letters.include?(guess)
      @gameview.repeated_guess
    else
      @guessed_letters.push(guess)
      update_board(guess)
    end
  end

  def board_state
    @output.puts "Guess the hidden word: #{board.join(" ")}"
  end

  def update_board(guess)
    if secret_word.include?(guess)
      @gameview.correct_guess(guess, lives)

      secret_word.chars.each_with_index do |character, index|
        board[index] = character if character == guess
      end
    else
      @lives -= 1
      @gameview.incorrect_guess(guess, lives)
    end
  end
end
