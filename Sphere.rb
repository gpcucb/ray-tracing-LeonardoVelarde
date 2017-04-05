require_relative 'Vector.rb'
require_relative 'Intersection.rb'

class Sphere
  attr_accessor :position, :radius, :material

  def initialize(position, radius, material)
    @position = position #center(c)
    @radius = radius.to_f
    @material = material
  end

  def intersection?(ray, t)
    e = ray.position
    d = ray.direction

    e_c = e.minus(@position)
    dd = d.times_K(2)

    a = d.dot_product(d)
    b = dd.dot_product(e_c)
    c = e_c.dot_product(e_c) - @radius ** 2

    discriminant = b**2-(4*a*c)

    return Intersection.unsuccessful if (discriminant < 0.0)

    t0 = ((b * -1) - Math.sqrt(discriminant))/(2 * a)
    t1 = ((b * -1) + Math.sqrt(discriminant))/(2 * a)

    success = false

    if ((t0 > 0.0) && (t0 < t))
      t = t0
      success = true
    end
    if ((t1 > 0.0) && (t1 < t))
      t = t1
      success = true
    end

    return Intersection.new(t, success)
  end

  def normal intersertion_point
    p_c = intersertion_point.minus(@position)
    return Vector.new(p_c.x/@radius,p_c.y/@radius,p_c.z/@radius)
  end

end
