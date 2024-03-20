#allows the use of the classes in the classes file
require_relative 'MstrMnd_classes'

create_game = Create_Game.new
create_game.rules
create_game.num_pegs
create_game.duplicates

play_game = Play_Game.new(create_game)
play_game.create_sequence

game_display= Display.new(play_game)

10.times do |guess_number|
  puts "Guess ##{guess_number + 1}:"
  play_game.guess
  game_display.guess_check(play_game.sequence, play_game.all_guesses.last)
  game_display.show
  break if play_game.sequence_guessed?||play_game.max_guesses_reached?
end

  if play_game.sequence_guessed?
    puts "Congratulations! You've guessed the sequence correcty!"
  else
    puts "You've used up all 10 guesses. The correct sequence was: #{play_game.sequence.join(' ')}" unless play_game.guess==play_game.sequence
  end

