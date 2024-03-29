#this class creates the game, displaying the rules ans asking the user if they want to allow duplicates and how many pegs they would like to use (4, 6 or 8)
class Create_Game
  attr_reader :pegs,:dups #allows variables to be accessed in Play_Game class
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
      puts"You will also have the choice between guessing 4, 6 or 8 pegs as well as choosing to allow dupliactes of colors to set the difficulty to your liking. After each guess, all previous guesses will be displayed and next to those guesses will be a combination of '*s','.'s' and/or 'x's'. A '*' means that you have a color in the right place. A '.' means that you have the right color and an 'x' tells you that you have the wrong color. But be warned, the order of the combination of \u2713's,.s' and x's isn't the same as the actual sequence of colors. *'s will always appear first, then .'s and then x's. The game is finished when you either use up all 10 guesses or get the sequence correct."
      puts "Enjoy :)"
    end
  end

  def num_pegs # asks the user for the number of pegs that they'd like to use. Must either be 4, 6 or 8.
    loop do
      print"Enter the number of pegs (4, 6 or 8): "
      @pegs=gets.chomp.to_i
      break if [4, 6, 8].include?(@pegs) #will continue ti ask the user until given a valid input
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
  attr_reader :sequence,:all_guesses #allows variables to be accessed by display class.
  
  def initialize(create_game) #initializes by using create_game instance while initializing the all_guesses array and max_guesses variable
    @create_game=create_game
    @all_guesses=[] #array that will store every guess.
    @max_guesses = 10
  end
  
  def colors #makes the list of the possible colors.
    ['r','g','b','y','p','o','w','s']
  end
  
  def create_sequence #creates sequence for either duplicates being included or excluded
    if @create_game.dups==false
      @sequence=colors.shuffle.take(@create_game.pegs)
    else
      @sequence=Array.new(@create_game.pegs) {colors.sample} #sequence for duplicates
    end
  end
  
  def guess #function that takes inut from the user as a guess of the sequence.
    puts "Enter guess, seperated by spaces:"
    @guess=gets.chomp.split(' ')
    @all_guesses << @guess
  end
  def sequence_guessed? #checks if the sequence was guessed correctly, returning true if it was.
    @all_guesses.include?(@sequence)
  end

  def max_guesses_reached? #checks if the max number of guesses was reached, returning true if it was.
    @all_guesses.length >= @max_guesses
  end
end

#The Display class contains all of the functions necessary to show the results of a guesses and previous guesses while checking the guesses goes hand in hand woth Play_Game.
class Display
  def initialize(play_game) #initializes using the play_game instance while creating an array for all checks for each guess
    @play_game=play_game
    @checks=[] #will store the corresponding checks for each guess in the correct order.
  end
  
  def guess_check(sequence, guess) #checks each guessagainst the sequence and returns the results.
    results=''
    guess.each_with_index do |color,index|
      if sequence[index]==color
        results += "*" # shown if the right color is in the right spot
      end
    end
    numChecks=results.size #gets size of the results after adding the *'s
    period_num=sequence.intersection(guess).length-numChecks #subtracts the number of *' from the number of .'s to avoid double counting
    period_num.times do
      results += '.' #shown if the right color is in the guess.
    end
    remaining=sequence.length-results.length #fills the rest of the results with x's until its the same size as sequence (= to number of pegs)
    remaining.times do
      results += 'x' #shown if the wrong color is included in the guess.
    end
    @checks<<results #appends results to the checks array
  end
  
  def show #prints out the previous guesses and their corresponding results to the terminal.
    @play_game.all_guesses.each_with_index do |guess, index|
      print "Guess #{index + 1}: #{guess.join(' ')}  "  # Print the guess
      puts "Check: #{@checks[index]}" #Prints results of the guess
    end
  end
end

