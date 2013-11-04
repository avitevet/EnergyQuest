require 'wall_location'
require 'open_location'
require 'direction'

class Board
  attr_accessor :locations
  
  def initialize(height, width, player)
    # create the board, which is a multidimensional array of BoardLocations
    # the board will be size (height + 2, width + 2).  The extra locations are the borders,
    # which will be initialized as WallLocations.  The others will be initialized as OpenLocations
    #
    # (height, width)
    # 0,0   0,1    0,2 ...
    # 1,0   1,1    1,2 ...
    self.locations = Array.new(height + 2) do |heightIndex| 
      Array.new(width + 2) do |widthIndex|
        if heightIndex == 0 || heightIndex == height + 1 ||
          widthIndex == 0 || widthIndex == width + 1
          WallLocation.new
        else
          OpenLocation.new
        end
      end 
    end
    
    # set ranges for food & player
    @hRange = (1..height)
    @wRange = (1..width)
    @playerLocation = [nil, nil]
    
    self.placeFoodRandomly
    self.placePlayerRandomly(player)
    #self.locations[1][1].food = true
  end

  def randomLocation
    [rand(@hRange), rand(@wRange)]
  end

  def placeFoodRandomly
    begin
      h, w = self.randomLocation()
    end while self.locations[h][w].player?

    self.locations[h][w].food = true 
  end

  def placePlayerRandomly(player)
    begin
      h, w = self.randomLocation()
    end while self.locations[h][w].food?

    self.locations[h][w].player = player
    # cache the player location
    @playerLocation = [h, w]
  end


  def validMove?(direction)
    case direction
    when Direction.UP
      case self.locations[height - 1][width]
      when WallLocation
        false
      else
        true
      end
    when Direction.DOWN
      case self.locations[height + 1][width]
      when WallLocation
        false
      else
        true
      end
    when Direction.LEFT
      case self.locations[height][width - 1]
      when WallLocation
        false
      else
        true
      end
    when Direction.RIGHT
      case self.locations[height][width + 1]
      when WallLocation
        false
      else
        true
      end
    else
      throw "Invalid direction!  This should never happen" 
    end
  end

  def to_s
    strs = self.locations.map do |rows|
      rows.map do |location|
        case location
        when WallLocation
          "W"
        when OpenLocation
          if location.player?
            "X"
#          elsif location.food?
#            "F"
          else
            "."
          end
        end
      end
    end
    
    strs.inject("") do |board, rows|
      rowStr = rows.inject("") do |row, location|
        row += location
      end
      board += rowStr + "\n"
    end
  end
end