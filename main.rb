#allows the use of the classes in the classes file
require_relative 'MstrMnd_classes'

create_game = Create_Game.new
create_game.rules
create_game.num_pegs
create_game.duplicates

play_game = Play_Game.new(create_game)
play_game.create_sequence

game_display= Display.new(game_logic)

10.times do |guess_number|
  puts "Guess ##{guess_number + 1}:"
  play_game.guess
  play_game.all_guesses

  game_display.guess_check(play_game.sequence, play_game.guess)
  game_display.all_checks

  game_display.show

  if play_game.guess==game_logic.sequence
    puts "Congratulations! You've guessed the sequence correcty!"
    break
  end
end
puts "You've used up all 10 guesses. The correct sequence was: #{game_logic.sequence.join(' ')}" unless play_game.guess==play_game.sequence

