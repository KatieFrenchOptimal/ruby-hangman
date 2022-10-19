require "./game_view"

describe GameView do
  let(:output) { StringIO.new }
  let(:game_view) { GameView.new(output, input: nil) }

  describe "#show_board_state" do
    it "shows the default board state" do
      secret_word = "Hello"
      board = [nil] * secret_word.size
      guesses = []

      game_view.show_board_state(board, guesses)

      expect(output.string).to include "_ _ _ _ _"
    end

    it "shows the updated board state" do
      secret_word = "Hello"

      board = [nil, "E", nil, nil, "O"]
      guesses = ["E", "O"]

      game_view.show_board_state(board, guesses)

      expect(output.string).to include "_ E _ _ O"
    end
  end

  describe "#won_message" do
    it "displays win message" do
      input = "hello"
      game_view.won_message(input.upcase)

      expect(output.string).to include "You won."
      expect(output.string).to include "The secret word was: HELLO."
    end
  end

  describe "#lost_message" do
    it "displays lost message" do
      input = "hello"
      game_view.lost_message(input.upcase)

      expect(output.string).to include "You lost."
      expect(output.string).to include "The secret word was: HELLO."
    end
  end

  describe "#invalid_guess_message" do
    it "displays invalid guess message" do
      game_view.invalid_guess_message

      expect(output.string).to include "Input is invalid - please provide a letter."
    end
  end

  describe "#repeated_guess_message" do
    it "displays repeated guess message" do
      game_view.repeated_guess_message

      expect(output.string).to include "You have already guessed this letter - try again."
    end
  end

  describe "#correct_guess_message" do
    it "displays correct guess message" do
      game_view.correct_guess_message("L", 9)

      expect(output.string).to include "Correct guess. The letter 'L' is in the word."
      expect(output.string).to include "You have 9 remaining lives left."
    end
  end

  describe "#incorrect_guess_message" do
    it "displays incorrect guess message" do
      game_view.incorrect_guess_message("B", 8)

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
