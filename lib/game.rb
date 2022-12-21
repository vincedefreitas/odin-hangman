class Game 
  attr_accessor :master_word, :hidden_word, :guessed_letters


  def initialize
    @master_word = []
    @hidden_word = []
    @guessed_letters = []
  end

  def select_random_word
    new_word_list = []
    File.open('word_list.txt', 'r') do |file|
      file.readlines.each do |line|
        new_word_list.push(line) if (line.length >= 6 && line.length <= 13)
      end
    end
    new_word_list.sample.chomp
  end