require 'wall_location'
require 'open_location'

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
  end

  def to_s
    strs = self.locations.map do |rows|
      rows.map do |location|
        case location
        when WallLocation
          "W"
        when location.player?
          "X"
        else
          "."
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