require "./secret_word"

describe SecretWord do
  let(:secret_word) { SecretWord.new("Hello") }

  it "can reveal the secret word" do
    expect(secret_word.reveal_word).to include "HELLO"
  end

  it "saves guessed letters" do
    secret_word.save_guess("a")

    expect(secret_word.guessed_letters).to include "a"
  end

  it "updates the board with correct guesses" do
    secret_word.save_guess("h")

    expect(secret_word.masked_word).to include "H"
  end
end
