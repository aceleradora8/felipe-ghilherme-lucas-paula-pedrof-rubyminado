require 'colorize'

class Campo 
	attr_accessor :campo
	attr_accessor :bombas

	# CONSTRUTOR
	# Recebe uma coordenada (x,y) e uma indicacao de flag (y/n)
	def initialize(x, y)
		@bombas = x
		@campo = gera_campo(x, y)
		gera_bombas
	end
	
	# Inicializa e retorna a variavel @campo a partir da coordenada (x,y)
	def gera_campo(x, y)
		campo = []
		x.times { campo.push([]) }
		campo.each do |array|
			y.times { array.push("■") }
		end
		return campo
	end

	#
	def gera_eixo_x()
		eixo_x = " "
		contador = 0
		@campo.length.times do
			num_str = " #{contador}"
			eixo_x.concat(num_str)
			contador += 1
		end
			eixo_x.concat("\n")
		print eixo_x
	end
	private :gera_eixo_x

	def mostra_campo()
		contador_linha = 0
		contador = 0
		gera_eixo_x
		@campo.each do |x|
			print "#{contador_linha} "
			contador_linha += 1
			x.each do |y|
				contador +=1
				if(y == "☢".red)
					print "■ "
				else
					print  y + " "
				end
				if contador == x.length
					puts
					contador = 0
				end
			end
		end
	end

	def mostra_campo_revelado()
		contador_linha = 0
		contador = 0
		gera_eixo_x
		@campo.each do |x|
			print "#{contador_linha} "
			contador_linha += 1
			x.each do |y|


				contador +=1
				print  y + " "
				if contador == x.length
					puts
					contador = 0
				end
			end
		end
	end

	def gera_bombas()
		contador = @bombas
		begin
			x = rand(@campo.length)
			y = rand(@campo.length)
			if(@campo[x][y] == "■")				
				@campo[x][y] = "☢".red
				contador -= 1
			end
		end while (contador != 0)
	end

end