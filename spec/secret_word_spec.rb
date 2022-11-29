require "./secret_word"

describe SecretWord do
  let(:secret_word) { SecretWord.new("Hello") }

  describe "#masked_word" do
    context "there are no guesses" do
      it "the word is masked" do
        expect(secret_word.masked_word).to eq([nil, nil, nil, nil, nil])
      end
    end

    context "the word has been partially guessed" do
      it "the word is partially masked" do
        secret_word.save_guess("l")
        secret_word.save_guess("e")
        expect(secret_word.masked_word).to eq([nil, "E", "L", "L", nil])
      end
    end

    context "the word has been full guessed" do
      it "the word is not masked" do
        secret_word.save_guess("l")
        secret_word.save_guess("h")
        secret_word.save_guess("o")
        secret_word.save_guess("e")
        expect(secret_word.masked_word).to eq(["H", "E", "L", "L", "O"])
      end
    end
  end

  describe "#reveal_word" do
    it "the word can be revealed" do
      expect(secret_word.reveal_word).to include "HELLO"
    end
  end

  describe "#guessed?" do
    context "when the word is guessed" do
      it "is truthy" do
        secret_word.save_guess("h")
        secret_word.save_guess("e")
        secret_word.save_guess("l")
        secret_word.save_guess("o")

        expect(secret_word.guessed?).to be_truthy
      end
    end

    context "when the word has not been guessed" do
      it "is falsy" do
        expect(secret_word.guessed?).to be_falsy
      end
    end
  end

  describe "#save_guess" do
    context "when the guess is correct" do
      it "is truthy" do
        expect(secret_word.save_guess("l")).to be_truthy

        expect(secret_word.guessed_letters).to include "L"
        expect(secret_word.masked_word).to include "L"
      end
    end

    context "when the guess is not correct" do
      it "is falsy" do
        expect(secret_word.save_guess("a")).to be_falsy

        expect(secret_word.guessed_letters).to include "A"
        expect(secret_word.masked_word).not_to include "A"
      end
    end
  end

  describe "#repeated_guess?" do
    context "when the guessed is repeated" do
      it "is truthy" do
        secret_word.save_guess("e")

        expect(secret_word.repeated_guess?("e")).to be_truthy
      end
    end

    context "when the guess is not repeated" do
      it "is falsy" do
        secret_word.save_guess("e")

        expect(secret_word.repeated_guess?("h")).to be_falsy
      end
    end
  end
end
