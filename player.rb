class Player
  attr_accessor :energy
  
  def initialize(initialEnergy, winEnergy)
    self.energy = initialEnergy
    @winEnergy = winEnergy
  end
  
  def dead?
    self.energy <= 0
  end
  
  def winner?
    self.energy >= @winEnergy
  end
end