require 'colorize'
load 'Icones.rb'

# matriz = [["l0c0","l1c1", l1]]
class Campo 
	attr_reader :array_bombas				# array de coordenadas das bombas
	attr_reader :array_bandeiras	# array de coordenadas das bandeiras
	attr_accessor :matriz						# matriz de representação do campo
 
 	# construtor
	def initialize(num_linhas, num_colunas)
		@num_bombas = (num_linhas * num_colunas) / 8
		@array_bombas = []
		@array_bandeiras = []
		@matriz = Array.new(num_linhas) { Array.new(num_colunas) }
		gera_campo!
	end
	
	# inicializa a matriz do jogo
	def gera_campo!()
		for i in 0..@matriz.length-1 do
			for j in 0..@matriz[i].length-1 do
				@matriz[i][j] = Icones::CELULA
			end
		end
		gera_bombas!
		gera_numeros!
	end

	# popula a matriz com as bombas 
	def gera_bombas!()
		bombas_criadas = 0
		while bombas_criadas < @num_bombas do
			bomba_linha = Random.rand(@matriz.length)
			bomba_coluna = Random.rand(@matriz[0].length)
			coord_bomba = [bomba_linha, bomba_coluna]
			unless @array_bombas.include?(coord_bomba)
				@array_bombas.push(coord_bomba)
				@matriz[bomba_linha][bomba_coluna] = Icones::BOMBA
				bombas_criadas += 1
			end
		end
	end

	# escreve o valor de marcacao na a posicao (linha,coluna) da matriz
	# A FAZER: algoritmo de encadeamento (provalvemente vai nesse metodo)
	def marca_campo!(marcacao, linha, coluna)
		if marcacao == Icones::BANDEIRA
			@array_bandeiras.push([linha, coluna])
		else
			@matriz[linha][coluna] = marcacao
		end
	end

	def gera_numeros!()
		for x in 0..@matriz.length-1 do
			for y in 0..@matriz[0].length-1 do
				num_bombas = 0
				unless(@matriz[x][y] == Icones::BOMBA)
					if y-1 >= 0
						num_bombas += 1 if @matriz[x][y-1] == Icones::BOMBA
					end
					if x-1 >= 0
						num_bombas += 1 if @matriz[x-1][y] == Icones::BOMBA
					end
					if y-1 >=0 && x-1 >= 0
						num_bombas += 1 if @matriz[x-1][y-1] == Icones::BOMBA
					end
					if y+1 < @matriz[0].length && x+1 < @matriz.length
						num_bombas += 1 if @matriz[x+1][y+1] == Icones::BOMBA
					end
					if x-1 >= 0 && y+1 < @matriz[0].length
						num_bombas += 1 if @matriz[x-1][y+1] == Icones::BOMBA
					end
					if y+1 < @matriz[0].length
						num_bombas += 1 if @matriz[x][y+1] == Icones::BOMBA
					end
					if x+1 < @matriz.length && y-1 >= 0
						num_bombas += 1 if @matriz[x+1][y-1] == Icones::BOMBA
					end
					if x+1 < @matriz.length
						num_bombas += 1 if @matriz[x+1][y] == Icones::BOMBA
					end
					@matriz[x][y] = num_bombas.to_s if num_bombas != 0
				end # fim unless
			end # fim for y
		end # fim for x
	end # fim do metodo

	# retorna uma String formatada do campo com as bombas ocultadas
	def campo_oculto_str()
		matriz_str = " "
		for i in 0..@matriz[0].length-1 do
			matriz_str += " #{i}"
		end

		for i in 0..@matriz.length-1 do
			matriz_str += "\n#{i}"
			for j in 0..@matriz[i].length-1 do
				celula = matriz[i][j]
				if celula == Icones::BOMBA
					matriz_str += "#{Icones::CELULA} "
				elsif @array_bandeiras.include?([i,j])
					matriz_str += "#{Icones::BANDEIRA} "
				else
					matriz_str += "#{celula} "
				#matriz_str += (celula == Icones::BOMBA ? "#{Icones::CELULA}" : "#{celula}")
				end
			end
		end
		return matriz_str
	end

	# retorna uma String formatada do campo com as bombas reveladas
	def campo_revelado_str()
		matriz_str = " "
		for i in 0..@matriz[0].length-1 do
			matriz_str += " #{i}"
		end

		for i in 0..@matriz.length-1 do
			matriz_str += "\n#{i} "
			for j in 0..@matriz[i].length-1 do
				matriz_str += (array_bandeiras.include?([i,j]) ? "#{Icones::BANDEIRA} " : "#{matriz[i][j]} ")
				#matriz_str += "#{@matriz[i][j]} "
			end
		end
		return matriz_str
	end

end
