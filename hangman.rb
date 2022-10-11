#!/usr/bin/env ruby

# to do:
# validate letters only
# do not accept repeated letters
# live/lives if more than 1

gameInProgress = true
lives = 9
guessedWords = []

secretWord = File.readlines("words.txt").sample.upcase.chop
board =  ["_"] * secretWord.size
puts board.join(" ")

while lives > 0 && board.include?("_")
  puts "Guess a letter:"
  guess = gets.chomp.upcase

  if secretWord.include?(guess)
    puts "Correct guess. The letter #{guess} is in the word. You have #{lives} remaining lives left"

    secretWord.chars.each_with_index do |character, index|
      next board[index] = character if character == guess
    end
  end

  lives -= 1

  if lives > 0
    puts "The word did not include #{guess}. You have #{lives} remaining lives left"
  end

  guessedWords.push(guess)
  puts "You have guessed: #{guessedWords.join(", ")}"

  p board.join(" ")
end

if board.join("") == secretWord
  puts "You won"
elsif lives <= 0
  puts "You lost. The word was: #{secretWord}"
end

puts "The word was #{secretWord}"
