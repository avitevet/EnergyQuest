require 'board_location'

class OpenLocation < BoardLocation
  
  def initialize
    @food = false
    @player = false
  end
 
  def food?
    @food
  end

  def food=(f)
    @food = f
  end

  def player?
    @player
  end
  
  def player=(p)
    @player = p
  end  
end