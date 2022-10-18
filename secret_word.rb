class SecretWord
  attr_reader :guessed_letters

  def initialize(hidden_word)
    @hidden_word = hidden_word.upcase
    @guessed_letters = []
    @board = [nil] * hidden_word.size
  end

  def masked_word
    @board
  end

  def reveal_word
    @hidden_word
  end

  def guessed?
    @board.join("") == @hidden_word
  end

  def save_guess(guess)
    update_secret_characters(guess)
    @guessed_letters.push(guess)
    @hidden_word.include?(guess)
  end

  def repeated_guess?(guess)
    @guessed_letters.include?(guess.upcase)
  end

  private

  def update_secret_characters(guess)
    @hidden_word.chars.each_with_index do |character, index|
      @board[index] = character if character == guess
    end
  end
end
