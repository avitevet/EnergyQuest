require 'direction'

class Command
  attr_accessor :text
  
  
  def valid?
    self.direction? || self.quit?
  end
  
  def invalid?
    !self.valid?
  end
  
  def direction?
    !direction.nil?
  end
  
  def direction
    case self.text
    when "U"
      Direction.UP
    when "D"
      Direction.DOWN
    when "L"
      Direction.LEFT
    when "R"
      Direction.RIGHT
    else
      nil
    end
  end
  
  def quit?
    self.text == "Quit"
  end
end
