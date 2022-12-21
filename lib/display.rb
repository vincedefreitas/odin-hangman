module Display 
  def how_to_play
    "How to play Hangman\n\nA random word will be chosen. On each turn, you can guess one letter.
    \nTo win, you must find all the letters in the word before using up your 8 guesses. Good luck!
    \n\nLet's play Hangman!"
  end

  def play_again_message
    "\nWould you like to play again?\n\n'1' for Yes\n'2' for No"
  end

end