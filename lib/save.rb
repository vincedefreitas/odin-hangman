
module Save

  def save_to_yaml
    YAML.dump({
      master_word: @master_word,
      hidden_word: @hidden_word,
      guessed_letters: @guessed_letters,
      incorrect_guesses_left: @incorrect_guesses_left,
    })
  end

  def choose_filename
    puts "Choose name for save file"
    @filename = gets.chomp
    @filename
  end

  def save_game
    File.open("saved/#{@filename}.yaml", 'w') { |file| file.write save_to_yaml }
  end

  def load_game
    get_save_file
    file = YAML.load(File.read("saved/#{@saved_game}.yaml"))
    @master_word = file[:master_word]
    @hidden_word = file[:hidden_word]
    @guessed_letters = file[:guessed_letters]
    @incorrect_guesses_left = file[:incorrect_guesses_left]
    File.delete("saved/#{@saved_game}.yaml") if File.exist?("saved/#{@saved_game}.yaml")
    until @game_over
      guess_letter
      check_guess(@guess)
      check_win
    end
    play_again
  end

  def file_names
    files = []
    Dir.entries('saved').each do |name|
      name.slice!('.yaml')
      files.push(name)
    end
    files
  end

  def show_file_names
    file_names.each { |name| puts name }
  end

  def get_save_file
    puts "Type your save file name to load the game"
    show_file_names
    file = gets.chomp
    @saved_game = file
  end





end