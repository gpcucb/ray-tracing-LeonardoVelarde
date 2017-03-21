require_relative 'Vector.rb'

class Camera
  attr_accessor :eye, :center, :up, :fov, :df

  def initialize(eye, center, up, fov, df)
    @eye = eye #vector
    @center = center #vector
    @up = up #vector
    @fov = fov.to_f # float
    @df = df # float
  end

  def vectorW
    d = Vector.restarVectores(@eye, @center)
    x = d.x / d.modulo
    y = d.y / d.modulo
    z = d.z / d.modulo
    return Vector.new(x, y, z)
  end

  def vectorU
    upPorW = @up.productoVectorial(vectorW)
    moduloDeE = @eye.modulo
    x = upPorW.x / moduloDeE
    y = upPorW.y / moduloDeE
    z = upPorW.z / moduloDeE
    return Vector.new(x, y, z)
  end

  def vectorV
    return Vector.productoVectorial(vectorW, vectorU)
  end

  def rayDirection(i, j, nx, ny)
    t = @df * Math::tan(@fov/2).to_f
    b = -t
    r = (t * nx) / ny
    l = -r
    u = l + (r − l) * (i + 0.5)/nx
    v = b + (t − b) * (j + 0.5)/ny
    menosdW = vectorW.multiplicarPorK(-@df)
    uu = vectorU.multiplicarPorK(u)
    vv = vectorV.multiplicarPorK(v)
    return menosdW.mas(uu).mas(vv)
  end
end
