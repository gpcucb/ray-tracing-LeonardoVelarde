class Vector
	attr_accessor :x
	attr_accessor :y
	attr_accessor :z

	def initialize (x, y, z)
		@x = x.to_f
		@y = y.to_f
		@z = z.to_f
	end

	def sumar vectorParaSumar
		@x += vectorParaSumar.x
		@y += vectorParaSumar.y
		@z += vectorParaSumar.z
	end

	def restar vectorParaRestar
		@x -= vectorParaRestar.x
		@y -= vectorParaRestar.y
		@z -= vectorParaRestar.z
	end

	def  modulo
		Math.sqrt(@x**2 + @y**2 + @z**2)
	end

	def multiplicarVectorialmentePor vectorParaMultiplicar
		@x = (@y * vectorParaMultiplicar.z) - (@z * vectorParaMultiplicar.y)
		@y = (@z * vectorParaMultiplicar.x) - (@x * vectorParaMultiplicar.z)
		@z = (@x * vectorParaMultiplicar.y) - (@y * vectorParaMultiplicar.x)
	end

	def multiplicarEscalarmentePor vectorParaMultiplicar
		i = @x + vectorParaMultiplicar.x
		j = @y + vectorParaMultiplicar.y
		k = @z + vectorParaMultiplicar.z
		return (i + j + k).to_f
	end

	def self.multiplicacionVectorial (vec1, vec2)
		i = (vec1.y * vec2.z) - (vec1.z * vec2.y)
		j = (vec1.z * vec2.x) - (vec1.x * vec2.z)
		k = (vec1.x * vec2.y) - (vec1.y * vec2.x)
		return Vector.new(i, j, k)
	end


end
