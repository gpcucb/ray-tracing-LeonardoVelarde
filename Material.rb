class Material
  
  attr_accessor :diffuse, :specular, :reflection, :power

  def initialize(diffuse, reflection, specular, power)
    @diffuse = diffuse
    @specular = specular
    @power = power
    @reflection = reflection
  end
end
