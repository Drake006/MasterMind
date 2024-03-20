#this class creates the game, displaying the rules ans asking the user if they want to allow duplicates and how many pegs they would like to use (4, 6 or 8)
class Create_Game
  attr_reader :pegs,:dups
  #displays the rules of the game if the user chooses to do so (they may not want to if they already know how to play).
  def rules
    print "Would you like to see the rules (y/n)?"
    if gets.chomp.downcase=='y'
      puts"Welcome to mastermind!!!"
      puts"Here you will try and guess the coreect sequence of colors represented by letters. The list of colors are:
      red='r'  green='g'  blue='b'  yellow='y'
      purple='p'  orange='o'  white='w'  silver='s'"
      puts"The guess should be inputted with space seperation like the example below:
      r o s w..."
      puts"You will also have the choice between guessing 4, 6 or 8 pegs as well as choosing to allow dupliactes of colors to set the difficulty to your liking. After each guess, all previous guesses will be displayed and next to those guesses will be a combination of '\u2713's','.'s' and/or 'x's'. A '\u2713' means that you have a color in the right place. A '.' means that you have the right color and an 'x' tells you that you have the wrong color. But be warned, the order of the combination of \u2713's,.s' and x's isn't the same as the actual sequence of colors. \u2713's will always appear first, then .'s and then x's. The game is finished when you either use up all 10 guesses or get the sequence correct. At the end, you will have the option to play again and choose different paramaters if you so please."
      puts "Enjoy :)"
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

#Play_game contains the functions that randomly selects the colors and stores the users guesses.
class Play_Game
  attr reader :sequence,:all_guesses
  def initialize(create_game)
    @create_game=create_game
    @all_guesses=[]
  end
  def colors
    ['r','g','b','y','p','o','w','s']
  end
  def create_sequence
    if @create_game.dups==false
      @sequence=colors.shuffle.take(@create_game.pegs)
    else
      @sequence=Array.new(@create_game.pegs) {colors.sample}
    end
  end
  def guess
    puts "Enter guess, seperated by spaces:"
    @guess=gets.chomp.split(' ')
  end
  def all_guesses
    @all_guesses << @guess
  end
  
end

#The Display class contains all of the functions necessary to show the results of a guesses and previous guesses while checking the guesses goes hand in hand woth Play_Game.
class Display
  def initialize(play_game)
    @play_game=play_game
    @checks=[]
  end
  
  def guess_check(sequence, guess)
    results=' '
    guess.each_with_index do |color,index|if sequence[index]==color
      results += \u2713
      results += ' '
    end
    numChecks=results.size
    period_num=sequence.intersection(guess).length-numChecks
    period_num.times do
      results += '. '
    end
    remaining=sequence.length-results.length
    remaining.times do
      results += 'x '
    end
  end
  
  def all_checks
    checks<<guess_check
  end
  
  def show
    @play_game.all_guesses.each_with_index do |guess, index|
      print "Guess #{index + 1}: #{guess.join(' ')}  "  # Print the guess
      puts "Check: #{@checks[index]}"
    end
  end
end

