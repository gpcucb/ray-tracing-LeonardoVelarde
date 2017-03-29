require_relative 'Vector.rb'
require_relative 'Intersection.rb'

class Sphere
  attr_accessor :position, :radius, :color

  def initialize(position, radius, color)
    @position = position #center(c)
    @radius = radius.to_f
    @color = color
  end

  def intersection?(ray, t)
    e = ray.position
    d = ray.direction

    e_c = e.minus(@position)
    dd = d.times_K(2)

    a = d.dot_product(d)
    b = dd.dot_product(e_c)
    c = e_c.dot_product(e_c) - @radius ** 2
    #puts "(A: #{a} , B: #{b} , C: #{c})"

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
end
