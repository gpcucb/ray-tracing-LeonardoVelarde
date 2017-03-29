class Vector
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z

	def initialize (x, y, z)
		@x = x.to_f
		@y = y.to_f
		@z = z.to_f
	end

	def show
		puts "(x: #{@x}, y:  #{@y}, z: #{@z})"
	end

	def plus vectorToAdd
		Vector.new(@x + vectorToAdd.x, @y + vectorToAdd.y, @z + vectorToAdd.z)
	end

	def minus vectorToSubstract
		Vector.new(@x - vectorToSubstract.x, @y - vectorToSubstract.y, @z - vectorToSubstract.z)
	end

	def times_K k
		x = @x * k
    y = @y * k
    z = @z * k
    return Vector.new(x, y, z)
	end

	def  modulo
		Math.sqrt(@x**2 + @y**2 + @z**2)
	end

	def dot_product vecForDotProduct
		i = @x * vecForDotProduct.x
		j = @y * vecForDotProduct.y
		k = @z * vecForDotProduct.z
		return (i + j + k).to_f
	end

	def cross_product vecForCrossProduct
		i = (@y * vecForCrossProduct.z) - (@z * vecForCrossProduct.y)
		j = (@z * vecForCrossProduct.x) - (@x * vecForCrossProduct.z)
		k = (@x * vecForCrossProduct.y) - (@y * vecForCrossProduct.x)
		return Vector.new(i, j, k)
	end

end
