#allows the use of the classes in the classes file
require_relative 'MstrMnd_classes'

create_game = Create_Game.new
create_game.rules
create_game.num_pegs
create_game.duplicates

play_game = Play_Game.new(create_game)
play_game.create_sequence
