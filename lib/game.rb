require_relative 'display'
require_relative 'save'
require 'yaml'

class Game 
  include Display
  include Save
  attr_accessor :master_word, :hidden_word, :guessed_letters


  def initialize
    @master_word = []
    @hidden_word = []
    @guessed_letters = []
    @incorrect_guesses_left = 8
    @game_over = false
    game_logic
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

  def guess_letter 
    puts @hidden_word.join
    puts guess_a_letter
    puts save_text
    @guess = gets.chomp.downcase
    if @guess == 'save'
      choose_filename
      save_game
      @game_over = true
    elsif @guess == 'exit'
      @game_over = true
    elsif @guess.length > 1 || @guess.match?(/[[:alpha:]]/) == false
      puts "That is an invalid answer, please try again"
      guess_letter
    elsif @hidden_word.include?(@guess) || @guessed_letters.include?(@guess)
      puts "You've already guessed this letter! Try again."
      guess_letter
    else
      @guess
    end
  end

  def check_guess(guess)
    if guess == 'save' || guess =='exit'
      @game_over = true
    elsif @master_word.include?(guess)
      @master_word.each_with_index do | letter, index |
        if guess == letter
          @hidden_word[index] = letter
        end
      end
    else
      @guessed_letters.push(guess)
      @incorrect_guesses_left -= 1
      puts "\nIncorrect! You have #{@incorrect_guesses_left} guesses left"
      puts "\nLetters guessed: #{guessed_letters.join}"
    end
  end

  def check_win
    if @hidden_word == @master_word
      puts @hidden_word.join
      puts "\nCongratulations, you figured out the secret word!"
      @game_over = true
    elsif @incorrect_guesses_left == 0
      puts "You lose! The secret word was #{@master_word.join}"
      @game_over = true
    end
  end

  def play_again
    puts play_again_message
    response = gets.chomp
    if response == '1'
      Game.new
    else
      puts "Thanks for playing!"
    end
  end

  def game_logic
    puts how_to_play
    player_choice
    until @game_over
      guess_letter
      check_guess(@guess)
      check_win
    end
    play_again
  end

  def player_choice
    puts new_game_choice
    choice = gets.chomp
    if choice == '1'
      select_master_word
      create_hidden_word
    else
      load_game
    end
  end

end

