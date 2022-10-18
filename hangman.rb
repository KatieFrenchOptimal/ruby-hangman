#!/usr/bin/env ruby

require "./game_view"
require "./secret_word"

class Hangman
  def initialize(input: $stdin, output: $stdout, secret_word: nil)
    @game_view = GameView.new(output, input)
    @lives = 9
    @secret_word = SecretWord.new(secret_word || File.readlines("words.txt").sample.chop)
  end

  def start
    while game_in_progress?
      @game_view.board_state(@secret_word.masked_word, @secret_word.guessed_letters)
      guess = @game_view.make_guess

      if @secret_word.repeated_guess?(guess)
        @game_view.repeated_guess
        next
      end

      if @secret_word.make_guess(guess)
        @game_view.correct_guess(guess, @lives)
      else
        @lives -= 1
        @game_view.incorrect_guess(guess, @lives)
      end
    end

    if @secret_word.guessed?
      @game_view.won(@secret_word.reveal_word)
    else
      @game_view.lost(@secret_word.reveal_word)
    end
  end

  def game_in_progress?
    @lives > 0 && !@secret_word.guessed?
  end
end
