require "./hangman"

describe Hangman do
  let (:hangman) { Hangman.new(secret_word: "Hello") }
  let (:game_view) { instance_double("GameView") }

  before do
    allow(game_view).to receive(:make_guess)
    allow(game_view).to receive(:show_board_state)
    allow(game_view).to receive(:won_message)
    allow(game_view).to receive(:lost_message)
    allow(game_view).to receive(:invalid_guess_message)
    allow(game_view).to receive(:repeated_guess_message)
    allow(game_view).to receive(:correct_guess_message)
    allow(game_view).to receive(:incorrect_guess_message)
    allow(game_view).to receive(:past_guesses)
  end

  it "can win a game" do
    allow(GameView).to receive(:new).and_return(game_view)
    allow(game_view).to receive(:make_guess).and_return("h", "e", "l", "o")

    expect(game_view).to receive(:won_message)

    hangman.start
  end

  it "can lose a game" do
    allow(GameView).to receive(:new).and_return(game_view)
    allow(game_view).to receive(:make_guess).and_return("a", "b", "c", "d", "f", "g", "i", "j", "k")

    expect(game_view).to receive(:lost_message)

    hangman.start
  end
end
