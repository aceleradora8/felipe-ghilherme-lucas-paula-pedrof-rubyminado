require 'colorize'
class Campo 
	attr_accessor :campo

	def initialize(x, y)
		@bombas = x
		@campo = gera_campo(x, y)
		gera_bombas
	end
	
	def gera_campo(x, y)
		campo = []
		x.times { campo.push([]) }
		campo.each do |array|
			y.times { array.push("■") }
		end
		return campo
	end

	def mostrar_linhas()
		@campo.length.times do |num| 
			if num == 0
				print "  #{num} "
			else
				print "#{num} "
			end	
		end
			puts ''
	end

	def mostra_campos()
		contador_linha = 0
		contador = 0
		
		mostrar_linhas
			 
		@campo.each do |x|
			print "#{contador_linha} "
			contador_linha += 1
			x.each do |y|
				contador +=1
				if(y == "☢")
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

	def mostra_campos_final()
		contador_linha = 0
		contador = 0
		
		mostrar_linhas
			 
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




