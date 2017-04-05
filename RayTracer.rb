require_relative 'Renderer.rb'
require_relative 'Camera.rb'
require_relative 'Vector.rb'
require_relative 'RGBColor.rb'
require_relative 'Intersection.rb'
require_relative 'Sphere.rb'
require_relative 'Triangle.rb'
require_relative 'Light.rb'
require_relative 'Material.rb'

class RayTracer < Renderer

  attr_accessor :camera

  def initialize(width, height)
    super(width, height, 250.0, 250.0, 250.0)

    @nx = @width
    @ny = @height
    # Camera values
    e = Vector.new(278, 273, -800)
    center = Vector.new(278, 273, -700)
    up = Vector.new(0, 1, 0)
    fov = 39.31
    df = 0.035
    @camera = Camera.new(e, center, up, fov, df)

    # Light Values
    light_color = RGBColor.new(0.8,0.7,0.6)
    light_position = Vector.new(0.0, 0.0, 200.0)
    @light = Light.new(light_position, light_color)

    # Sphere 1 values
    position = Vector.new(0, 0, 500)
    radius = 100
    sphere_diffuse = RGBColor.new(64, 111, 252, false)
    sphere_specular = RGBColor.new(1.0, 1.0, 1.0)
    sphere_reflection = 0.5
    sphere_power = 60
    sphere_material = Material.new(sphere_diffuse, sphere_reflection, sphere_specular, sphere_power)

    # Sphere _2 values
    position_2 = Vector.new(70, 70, 400)
    radius_2 = 70
    sphere_diffuse_2 = RGBColor.new(5, 156, 11, false)
    sphere_specular_2 = RGBColor.new(1.0, 1.0, 1.0)
    sphere_reflection_2 = 0.5
    sphere_power_2 = 160
    sphere_material_2 = Material.new(sphere_diffuse_2, sphere_reflection_2, sphere_specular_2, sphere_power_2)

    # Sphere _3 values
    position_3 = Vector.new(70+60, 60+70, 300)
    radius_3 = 80
    sphere_diffuse_3 = RGBColor.new(113, 51, 172, false)
    sphere_specular_3 = RGBColor.new(1.0, 1.0, 1.0)
    sphere_reflection_3 = 0.5
    sphere_power_3 = 160
    sphere_material_3 = Material.new(sphere_diffuse_3, sphere_reflection_3, sphere_specular_3, sphere_power_3)

    # Sphere _4 values
    position_4 = Vector.new(60+70+80, 60+70+80, 200)
    radius_4 = 100
    sphere_diffuse_4 = RGBColor.new(46, 235, 198, false)
    sphere_specular_4 = RGBColor.new(1.0, 1.0, 1.0)
    sphere_reflection_4 = 0.5
    sphere_power_4 = 160
    sphere_material_4 = Material.new(sphere_diffuse_4, sphere_reflection_4, sphere_specular_4, sphere_power_4)

    # Triangle values
    a = Vector.new(552,8,0)
    b = Vector.new(0,0,0)
    c = Vector.new(0,0,560)
    triangle_diffuse = RGBColor.new(28, 111, 86, false)
    triangle_specular = RGBColor.new(1.0, 1.0, 1.0)
    triangle_reflection = 0.5
    triangle_power = 60
    triangle_material = Material.new(triangle_diffuse, triangle_reflection, triangle_specular, triangle_power)

    @sphere = Sphere.new(position, radius, sphere_material)
    @sphere_2 = Sphere.new(position_2, radius_2, sphere_material_2)
    @sphere_3 = Sphere.new(position_3, radius_3, sphere_material_3)
    @sphere_4 = Sphere.new(position_4, radius_4, sphere_material_4)
    @triangle = Triangle.new(a, b, c, triangle_material)
    @objects = []
    @objects << @sphere << @sphere_2 << @sphere_3 << @sphere_4
  end

  def max(a, b)
    if a > b
      return a
    end
    return b
  end

  def fix a
    if(a >= 1)
      a = 1
    end
    if(a <= 0)
      a = 0
    end
    return a
  end

  def lamberthian_shading intersection_point, intersection_normal, ray, light, object
    n = intersection_normal.normal
    l = light.position.minus(intersection_point).normal
    nl = fix n.dot_product(l)
    max = max(0, nl)
    kd = object.material.diffuse
    kdI = kd.times_color(light.color)
    kdI.times_K(max)
  end

  def blinn_phong_shading intersection_point, intersection_normal, ray, light, object
    n = intersection_normal.normal
    v = ray.position.minus(intersection_point).normal
    l = light.position.minus(intersection_point).normal
    h = v.plus(l).normal
    nh = fix n.dot_product(h)
    ks = object.material.specular
    power = object.material.power
    ksI = ks.times_color(light.color)
    max = max(0, nh)
    ksI.times_K(max ** power)
  end

  def ambient_shading(object)
    @ambient_light = RGBColor.new(0.5, 0.5, 0.5)
    ka = object.material.diffuse
    return @ambient_light.times_color(ka)
  end

  def calculate_pixel(i, j)
    e = @camera.e
    dir = @camera.ray_direction(i,j,@nx,@ny)
    ray = Ray.new(e, dir)
    t = Float::INFINITY

    @obj_int = nil
    @objects.each do |obj|
      intersection = obj.intersection?(ray, t)
      if intersection.successful?
        @obj_int = obj
        t = intersection.t
      end
    end
    if @obj_int == nil
      color = RGBColor.new(i%255, j%255, (i+j)%255, false)
    else
      # color = @obj_int.material.diffuse
      intersection_point = ray.position.plus(ray.direction.times_K(t))
      intersection_normal = @obj_int.normal(intersection_point)
      lambert_shadow = lamberthian_shading(intersection_point, intersection_normal, ray, @light, @obj_int)
      blinn_phong = blinn_phong_shading(intersection_point, intersection_normal, ray, @light, @obj_int)
      ambient_shadow = ambient_shading(@obj_int)
      color = blinn_phong.plus_color(lambert_shadow).plus_color(ambient_shadow).fix_max_and_min_color_range
    end

    return {red: color.red, green: color.green, blue: color.blue}
  end
end
