require "./game_view"

describe Gameview do
  let(:output) { StringIO.new }
  let(:game_view) { Gameview.new(output) }

  describe "#won" do
    it "displays win message" do
      game_view.won("Hello")

      expect(output.string).to include "You won."
      expect(output.string).to include "The secret word was: Hello."
    end
  end

  describe "#lost" do
    it "displays lost message" do
      game_view.lost("Hello")

      expect(output.string).to include "You lost."
      expect(output.string).to include "The secret word was: Hello."
    end
  end

  describe "#invalid_guess" do
    it "displays invalid guess message" do
      game_view.invalid_guess

      expect(output.string).to include "Input is invalid - please provide a letter."
    end
  end

  describe "#repeated_guess" do
    it "displays repeated guess message" do
      game_view.repeated_guess

      expect(output.string).to include "You have already guessed this letter - try again."
    end
  end

  describe "#correct_guess" do
    it "displays correct guess message" do
      game_view.correct_guess("L", 9)

      expect(output.string).to include "Correct guess. The letter 'L' is in the word."
      expect(output.string).to include "You have 9 remaining lives left."
    end
  end

  describe "#incorrect_guess" do
    it "displays incorrect guess message" do
      game_view.incorrect_guess("B", 8)

      expect(output.string).to include "The secret word does not include the letter 'B'."
      expect(output.string).to include "You have 8 remaining lives left."
    end
  end

  describe "#past_guesses" do
    it "displays past guesses" do
      game_view.past_guesses(["H"])

      expect(output.string).to include "Your guesses: 'H'"
    end
  end
end
