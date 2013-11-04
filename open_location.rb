require 'board_location'

class OpenLocation < BoardLocation
  
  def initialize
    @food = false
    @player = false
  end
 
  def food?
    @food
  end

  def player?
    @player
  end  
end