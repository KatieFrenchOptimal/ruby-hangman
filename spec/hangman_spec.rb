require "./hangman"

describe Hangman do
  let(:game) { Hangman.new }

  context "on game start up" do
    it "user should have 9 lives" do
      expect(game.lives).to eq 9
    end

    it "should generate a secret word" do
      expect(game.secret_word).to_not be_empty
    end

    it "board should have an underscore for every character of the secret word" do
      expect(game.board.length).to eq game.secret_word.size
    end
  end
end
