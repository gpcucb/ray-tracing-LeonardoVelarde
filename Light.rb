class Light
  
  attr_accessor :position, :color

  def initialize position, color
    @position = position#vector
    @color = color#RGBColor
  end
end
