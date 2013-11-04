require 'board'
require 'player'
require 'command'
require 'food'

# start with 50, win @ 100
player = Player.new(50, 100)

# food is worth 20
food = Food.new(20)

# 5x5 board
board = Board.new(5, 5)
board.placeFoodRandomly(food)
board.placePlayerRandomly(player)

command = Command.new

quit = false


while (!quit)
  puts "Player has #{player.energy} energy remaining"
  puts board
  puts "What to do, what to do... (u, d, l, r, quit)"

  command.text = STDIN.gets.chomp
  
  if command.valid?
    #puts "command is valid"
    if command.quit?
      quit = true
    elsif command.direction?
      if board.move(command.direction)
        foodEaten = board.computeNewEnergies
        if foodEaten
          puts "*** You found and ate the food and got #{foodEaten.energy} more energy!"
        end

        if player.winner?
          puts "You won the game with #{player.energy} energy!"
          quit = true
        end
        if player.dead?
          puts "Player has died :("
          quit = true
        end

      else
        puts "*** Invalid move"
      end
    end
  else
    puts "*** Invalid command!"
  end
  
  puts "\n"
end

puts "Thanks for playing Avi Tevet's implementation of Energy Quest!"
