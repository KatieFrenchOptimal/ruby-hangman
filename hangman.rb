#!/usr/bin/env ruby

lives = 9
guessed_letters = []
secret_word = File.readlines("words.txt").sample.upcase.chop
board =  ["_"] * secret_word.size

while lives > 0 && board.include?("_")
  puts "Try to guess this hidden word: #{board.join(" ")}"
  print "Guess a letter: "

  guess = gets.chomp.upcase

  if guessed_letters.include?(guess)
    puts "------------------------------------------------------------------------"
    puts "You have already guessed this letter - try again."
    puts "------------------------------------------------------------------------"
    next
  end

  unless guess =~ /^[a-zA-Z]$/
    puts "------------------------------------------------------------------------"
    puts "Input is invalid - please provide a letter."
    puts "------------------------------------------------------------------------"
    next
  end

  if secret_word.include?(guess)
    puts "------------------------------------------------------------------------"
    puts "Correct guess. The letter #{guess} is in the word."
    puts "You have #{lives > 1 ? 'lives' : 'life'} remaining lives left."

    secret_word.chars.each_with_index do |character, index|
      board[index] = character if character == guess
    end
  else
    lives -= 1
    puts "------------------------------------------------------------------------"
    puts "The secret word does not include the letter '#{guess}'."
    puts "You have #{lives} remaining #{lives > 1 ? 'lives' : 'life'} left." if lives > 0
  end

  guessed_letters.push(guess)
  puts "Your guesses: '#{guessed_letters.join("', '")}'"
end

if board.join("") == secret_word
  puts "You won."
  puts "------------------------------------------------------------------------"
elsif lives <= 0
  puts "You lost."
  puts "The secret word was: #{secret_word}."
  puts "------------------------------------------------------------------------"
end
