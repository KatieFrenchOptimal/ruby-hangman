#!/usr/bin/env ruby

gameInProgress = true

lives = 9

secretWord = File.readlines("words.txt").sample.upcase.chop
puts secretWord
board =  ["_"] * secretWord.size
puts board.join(" ")

while lives > 0 && board.include?("_")
  puts "Please guess a letter:"
  guess = gets.chomp.upcase
  puts "You guessed: '#{guess}'"
  puts "You have #{lives} remaining lives left."

  if secretWord.include?(guess)
    secretWord.chars.each_with_index do |character, index|
      if character == guess
        board[index] = character
      end
    end
  else
    lives -= 1
    puts "The word did not include #{guess}"
  end

  p board.join(" ")
end

if board.join("") == secretWord
  puts "You won"
elsif lives <= 0
  puts "You lost. The word was: #{secretWord}"
end

puts "The word was #{secretWord}"
