#allows the use of the classes in the classes file
require_relative 'MstrMnd_classes'

create_game = Create_Game.new #initializes game
#set up for the game
create_game.rules 
create_game.num_pegs
create_game.duplicates


play_game = Play_Game.new(create_game) #initializes the play game class object
play_game.create_sequence #creates the random sequence that will be used for the game

game_display= Display.new(play_game) #intializes the display game class object

10.times do |guess_number| #allows for a max of 10 guesses, will stop early if the sequence is guessed correctly.
  puts "Guess ##{guess_number + 1}:"
  play_game.guess #lets the user input their guess
  game_display.guess_check(play_game.sequence, play_game.all_guesses.last)
  game_display.show #shows all previous guesses and their corresponding results.
  break if play_game.sequence_guessed?||play_game.max_guesses_reached?
end

#Victory and failure statements
  if play_game.sequence_guessed?
    puts "Congratulations! You've guessed the sequence correcty!"
  else
    puts "You've used up all 10 guesses. The correct sequence was: #{play_game.sequence.join(' ')}" unless play_game.guess==play_game.sequence
  end

