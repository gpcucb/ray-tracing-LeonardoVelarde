class RGBColor
	attr_accessor :red
	attr_accessor :green
	attr_accessor :blue

	def initialize (red, green, blue)
		@red = red / 255.0
		@green = green / 255.0
		@blue = blue / 255.0
	end
end
