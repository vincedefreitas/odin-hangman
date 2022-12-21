

# alphabet = ('a'..'z').to_a
master_word = select_random_word.split('')
hidden_word = Array.new(master_word.length, '_')
guessed_letters = []
game_over = false

puts "Welcome to hangman!"
p master_word
p hidden_word

until game_over
  puts hidden_word.join
  puts "\nGuess a letter"
  guess = gets.chomp

  if master_word.include?(guess)
    master_word.each_with_index do | letter, index |
      if guess == letter
        hidden_word[index] = letter
      end
    end
  else
    guessed_letters.push(guess)
    puts "\nIncorrect!"
    puts "\nLetters guessed: #{guessed_letters.join}"
  end

  if hidden_word == master_word
    puts hidden_word.join
    puts "\nCongratulations, you figured out the secret word!"
    game_over = true
  end
end


