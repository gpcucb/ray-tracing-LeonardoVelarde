require_relative  'Camera.rb'
require_relative  'RGBColor.rb'
require_relative  'Vector.rb'
require_relative  'Ray.rb'

e = Vector.new(1, 2, -6)
center = Vector.new(1, 2, -4)
up = Vector.new(0, 1, 0)
fov = 39.0
df = 1.0
ny = 480
nx = 640

camera = Camera.new(e, center, up, fov, df)

(0..nx).each do |i|
  (0..ny).each do |j|
    dir = camera.rayDirection(i, j, nx, ny)
    dir.show
  end
end
