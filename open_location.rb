require 'board_location'

class OpenLocation < BoardLocation
  
  def initialize
    @food = nil
    @player = nil
  end
 
  def food?
    !@food.nil?
  end

  def food=(f)
    @food = f
  end
  
  def food
    @food
  end

  def player?
    !@player.nil?
  end
  
  def player=(p)
    @player = p
  end
  
  def player
    @player
  end 
end