class Game 
  attr_accessor :master_word, :hidden_word, :guessed_letters


  def initialize
    @master_word = []
    @hidden_word = []
    @guessed_letters = []
    @incorrect_guesses_left = 8
  end

  def select_master_word
    new_word_list = []
    File.open('word_list.txt', 'r') do |file|
      file.readlines.each do |line|
        new_word_list.push(line) if (line.length >= 6 && line.length <= 13)
      end
    end
    @master_word = new_word_list.sample.chomp.split('')
  end

  def create_hidden_word
    @hidden_word = Array.new(@master_word.length, '_')
  end


end

game = Game.new
game.select_master_word
game.create_hidden_word
p game.master_word
p game.hidden_word

