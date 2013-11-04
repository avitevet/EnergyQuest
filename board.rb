require 'wall_location'
require 'open_location'
require 'direction'


class Board
  attr_accessor :locations
  
  def initialize(height, width)
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
    @playerCoords = [nil, nil]
  end

  def at(h,w)
    self.locations[h][w]
  end

  def currentPlayerLocation
    h, w = @playerCoords
    self.at(h, w)
  end

  def randomLocation
    [rand(@hRange), rand(@wRange)]
  end

  def placeFoodRandomly(food)
    begin
      h, w = self.randomLocation()
    end while self.at(h, w).player?

    self.at(h, w).food = food 
  end

  def placePlayerRandomly(player)
    begin
      h, w = self.randomLocation()
    end while self.at(h, w).food?

    self.at(h, w).player = player
    # cache the player location
    @playerCoords = [h, w]
  end


  def move(direction)
    h, w = @playerCoords
    newH, newW = direction.moveFrom(h, w)
    
    currentLocation = self.currentPlayerLocation() 
    newLocation = self.at(newH, newW)


    case newLocation
    when WallLocation
      false
    else
      # actually move the player
      newLocation.player = self.at(h, w).player
      self.at(h, w).player = nil
      @playerCoords = [newH, newW]
      true
    end
  end

  # returns the food that was eaten if it was consumed, nil otherwise
  def computeNewEnergies
    cur = currentPlayerLocation()
    
    # subtract the energy needed for moving
    cur.player.energy -= 1
    
    if cur.food?
      # consume & move the food
      food = cur.food
      cur.player.energy += food.energy  
      
      self.placeFoodRandomly(food)
      cur.food = nil
      
      food
    else
      nil
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