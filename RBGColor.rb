class RGBColor

	attr_accessor :red
  attr_accessor :green
  attr_accessor :blue

	def initialize (red, green, blue)
		@red = red.to_f
		@green = green.to_f
		@blue = blue.to_f
	end

end
