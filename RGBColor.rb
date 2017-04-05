class RGBColor
	attr_accessor :red
	attr_accessor :green
	attr_accessor :blue

	def initialize (red, green, blue, float_values = true)
		if float_values
			@red = red.to_f
			@green = green.to_f
			@blue = blue.to_f
		else
			@red = red.to_f / 255.0
			@green = green.to_f / 255.0
			@blue = blue.to_f / 255.0
		end
	end

	def times_color color
		r = @red * color.red
		g = @green * color.green
		b = @blue * color.blue
		return RGBColor.new(r, g, b)
	end

  def times_K k
		k = k.to_f
    r = @red * k
    g = @green * k
    b = @blue * k
    return RGBColor.new(r, g, b)
  end

  def plus_color color
    r = @red + color.red
    g = @green + color.green
    b = @blue + color.blue
    return RGBColor.new(r, g, b)
  end

	def fix_max_and_min_color_range
		if(@red > 1.0)
			@red = 1.0
		end
		if(@red < 0)
			@red = 0.0
		end
		if(@green > 1.0)
			@green = 1.0
		end
		if(@green < 0)
			@green = 0.0
		end
		if(@blue > 1.0)
			@blue = 1.0
		end
		if(@blue < 0)
			@blue = 0.0
		end
		return self
	end

end
