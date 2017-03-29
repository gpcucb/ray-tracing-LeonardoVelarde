require_relative 'Vector.rb'

class Camera
  attr_accessor :e, :center, :up, :fov, :df

  def initialize(e, center, up, fov, df)
    @e = e #vector
    @center = center #vector
    @up = up #vector
    @fov = ((fov * Math::PI)/180).to_f#why? convert degrees to radians
    @df = df # float
  end

  def vectorW
    d = @center.minus(@e)
    x = d.x / d.modulo
    y = d.y / d.modulo
    z = d.z / d.modulo
    return Vector.new(-x, -y, -z)
  end

  def vectorU
    upPorW = @up.cross_product(vectorW)
    x = upPorW.x / upPorW.modulo
    y = upPorW.y / upPorW.modulo
    z = upPorW.z / upPorW.modulo
    return Vector.new(x, y, z)
  end

  def vectorV
    return vectorW.cross_product(vectorU)
  end

  def rayDirection(i, j, nx, ny)
    t = @df * Math::tan(@fov/2).to_f
    b = -t
    r = ((t * nx) / ny).to_f
    l = -r
    u = l + (r - l) * (i + 0.5)/nx
    v = b + (t - b) * (j + 0.5)/ny
    dw = vectorW.times_K(-@df)
    uu = vectorU.times_K(u)
    vv = vectorV.times_K(v)
    return (dw.plus(uu)).plus(vv)
  end
end
