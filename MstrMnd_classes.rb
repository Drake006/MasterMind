#this class creates the game, displaying the rules ans asking the user if they want to allow duplicates and how many pegs they would like to use (4, 6 or 8)
class Create_Game
  attr_reader :pegs,:dups
  #displays the rules of the game if the user chooses to do so (they may not want to if they already know how to play).
  def rules
    print "Would you like to see the rules (y/n)?"
    if gets.chomp.downcase=='y'
      puts"Welcome to mastermind!!! Here you will try and guess the coreect sequence of colors represented by letters. The list of colors are:
      red='r'  green='g'  blue='b'  yellow='y'
      purple='p'  orange='o'  white='w'  silver='s'
      The guess should be inputted with space seperation like the example below:
      r o s w..."
      puts"You will also have the choice between guessing 4, 6 or 8 pegs as well as choosing to allow dupliactes of colors to set the difficulty to your liking. After each guess, all previous guesses will be displayed and next to those guesses will be a combination of '\u2713's','.' and 'x'. a '\u2713' means that you have a color in the right place. A '.' means that you have the right color and an 'x' tells you that you have the wrong color. But be warned the order of the combination of \u2713's,.s' and x's isn't the same as the actual sequence of colors. \u2713's will always appear first, then .'s and then x's. Once the Game is finished you will have the option to select a play again and choose different paramaters (or the same ones) is you so please. Enjoy :)"
    end
  end
  
  def num_pegs # asks the user for the number of pegs that they'd like to use. Must either be 4, 6 or 8.
    loop do
      print"Enter the number of pegs (4, 6 or 8): "
      @pegs=gets.chomp.to_i
      break if [4, 6, 8].include?(@pegs)
    end
  end
  
  def duplicates #asks the user if they would like to allow duplicates.
    loop do
      print "Allow Duplicates (y/n): "
      input=gets.chomp.downcase #makes the input downcase just in case its entered as an uppercase letter.
      #if statements ensure that a valid input is used.
      if input=='y'
        @dups=true
        break
      elsif input=='n'
        @dups=false
        break
      else
        puts"Invalid input. Please enter 'y' for yes or 'n' for no."
      end
    end
  end
end

#Play_game contains the functions that randomly selects the colors and stores the users guesses, works with the Display class.
class Play_Game
  def initialize(create_game)
    @create_game=create_game
  end
  def colors
    @colors=['r','g','b','y','p','o','w','s']
  end
  def create_sequence
    pegs=@create_game.pegs
    puts "working!!!!"
  end
end

#The Display class contains all of the functions necessary to show the results of a guesses and previous guesses, goes hand in hand woth Play_Game.
class Display
end

