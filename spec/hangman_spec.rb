require "./hangman"

describe Hangman do
  let(:game) { Hangman.new() }

  context "on game start up" do
    it "user should have 9 lives" do
      expect(game.lives).to eq(9)
    end
  end
end
