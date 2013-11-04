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
    !self.direction().nil?
  end
  
  def direction
    case self.text.upcase
    when "U"
      Direction::Up
    when "D"
      Direction::Down
    when "L"
      Direction::Left
    when "R"
      Direction::Right
    else
      nil
    end
  end
  
  def quit?
    self.text.downcase == "quit" || self.text.downcase == "q" 
  end
end
