module Direction
  class Up
    def self.moveFrom(h, w)
      [h - 1, w]
    end
  end
  
  class Down
    def self.moveFrom(h, w)
      [h + 1, w]
    end
  end
  
  class Left
    def self.moveFrom(h, w)
      [h, w - 1]
    end
    
  end
  
  class Right
    def self.moveFrom(h, w)
      [h, w + 1]
    end
  end
end