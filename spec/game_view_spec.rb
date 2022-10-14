require "./game_view"

describe Gameview do
  let(:output) { StringIO.new }
  let(:game_view) { Gameview.new(output) }

  describe "#won" do
    it "displays win message" do
      game_view.won

      expect(output.string).to include "You won."
    end
  end

  describe "#lost" do
    it "displays lost message" do
      game_view.lost("Hello")

      expect(output.string).to include "You lost."
      expect(output.string).to include "The secret word was: Hello."
    end
  end
end
