require "./hangman"

describe Hangman do

  it "can be won" do
    output = StringIO.new
    input = build_input("eohl".chars)
    secret_word = "Hello"

    Hangman.new(output: output, input: input, secret_word: secret_word).start

    expect(output.string).to include "Your guesses: 'E', 'O', 'H', 'L'"
    expect(output.string).to include "Guess the hidden word: _ E _ _ O"
    expect(output.string).to include "Correct guess. The letter L is in the word"
    expect(output.string).to include "You won."
    expect(output.string).not_to include "You have 8 remaining lives left."
  end

  it "can be lost" do
    output = StringIO.new
    input = build_input("xzvbnrqws".chars)
    secret_word = "Hello"

    Hangman.new(output: output, input: input, secret_word: secret_word).start

    expect(output.string).to include "You have 1 remaining life left."
    expect(output.string).to include "You lost."
    expect(output.string).to include "Your guesses: 'X', 'Z', 'V', 'B', 'N', 'R', 'Q', 'W', 'S'"
    expect(output.string).to include "The secret word does not include the letter 'W'."
    expect(output.string).to include "The secret word was: HELLO."
  end

  it "will not lose life for invalid input" do
    output = StringIO.new
    input = build_input("ll4eoh".chars)
    secret_word = "Hello"

    Hangman.new(output: output, input: input, secret_word: secret_word).start

    expect(output.string).to include "Input is invalid - please provide a letter."
    expect(output.string).to include "You have already guessed this letter - try again."
    expect(output.string).not_to include "You have 8 remaining lives left."

  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
