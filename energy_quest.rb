require 'board'
require 'player'
require 'command'

# start with 50, win @ 100
player = Player.new(50, 100)

# 5x5 board
board = Board.new(5, 5, player)

command = Command.new

quit = false


while (!quit)
  puts "Player has #{player.energy} energy remaining"
  puts board
  puts "What to do, what to do... (U, D, L, R, Quit)"

  command.text = STDIN.gets
  
  if command.valid?
    puts "command is valid"
    if command.quit?
      quit = true
    elsif command.direction?
      if board.validMove?(command.direction)
        board.move(command.direction)
        
        if player.dead?
          puts "Player has died :("
          quit = true
        end
      else
        puts "Invalid move"
      end
    end
  end
end

puts "Thanks for playing Avi Tevet's implementation of Energy Quest!"
