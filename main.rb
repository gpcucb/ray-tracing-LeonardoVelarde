require 'rubygems'
require_relative  'Camera.rb'
require_relative  'RGBColor.rb'
require_relative  'Vector.rb'
require_relative  'Ray.rb'
require_relative  'RayTracer.rb'
require_relative  'Sphere.rb'
require_relative  'Triangle.rb'

renderer = RayTracer.new(640.0, 480.0)
renderer.render('Raytracing', 'raytracing.png')
