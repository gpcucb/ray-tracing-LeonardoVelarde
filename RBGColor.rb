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

colorToTest = RGBColor.new(10, 11, 12)

puts colorToTest
puts colorToTest.red
puts colorToTest.green
puts colorToTest.blue	
