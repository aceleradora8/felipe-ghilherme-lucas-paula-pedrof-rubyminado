require 'colorize'
load 'Icones.rb'

class Campo 
	attr_reader :array_bombas				# array de coordenadas das bombas
	attr_reader :array_bandeiras	# array de coordenadas das bandeiras
	attr_accessor :matriz						# matriz de representação do campo
 
	def initialize(num_linhas, num_colunas)
		@num_bombas = (num_linhas * num_colunas) / 3
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
			numero_celula = gera_numero_celula(linha, coluna) # 2
			if(numero_celula > 0)
				@matriz[linha][coluna] = numero_celula.to_s
			else
				#revela_em_massa!(linha, coluna)
			end
		end
	end

	def revela_em_massa!(linha, coluna)
		indice_bombas_celula = gera_numero_celula(linha, coluna)
		if meu_numero == 0
			@matriz[linha][coluna] == Icones::CELULA_ABERTA
			# recursao 8x
		end
	end

	def gera_indice_bombas_celula(linha, coluna)
		num_bombas = 0
		unless(@matriz[linha][coluna] == Icones::BOMBA)
			if coluna-1 >= 0 && @matriz[linha][coluna-1] == Icones::BOMBA
				num_bombas += 1
			end
			if linha-1 >= 0 && @matriz[linha-1][coluna] == Icones::BOMBA
				num_bombas += 1 
			end
			if coluna-1 >=0 && linha-1 >= 0 && @matriz[linha-1][coluna-1] == Icones::BOMBA
				num_bombas += 1 end
			if coluna+1 < @matriz[0].length && linha+1 < @matriz.length && @matriz[linha+1][coluna+1] == Icones::BOMBA
				num_bombas += 1
			end
			if linha-1 >= 0 && coluna+1 < @matriz[0].length && @matriz[linha-1][coluna+1] == Icones::BOMBA
				num_bombas += 1
			end
			if coluna+1 < @matriz[0].length && @matriz[linha][coluna+1] == Icones::BOMBA
				num_bombas += 1
			end
			if linha+1 < @matriz.length && coluna-1 >= 0 && @matriz[linha+1][coluna-1] == Icones::BOMBA
				num_bombas += 1
			end
			if linha+1 < @matriz.length && @matriz[linha+1][coluna] == Icones::BOMBA
				num_bombas += 1
			end
		end
		return num_bombas
	end

	# retorna uma String formatada do campo com as bombas ocultadas
	def campo_oculto_str()
		matriz_str = " "
		for i in 0..@matriz[0].length-1 do
			matriz_str += " #{i}"
		end

		for i in 0..@matriz.length-1 do
			matriz_str += "\n#{i} "
			for j in 0..@matriz[i].length-1 do
				celula = matriz[i][j]
				if @array_bandeiras.include?([i,j])
					matriz_str += "#{Icones::BANDEIRA} "
				else
					matriz_str += (celula == Icones::BOMBA ? "# " : "#{celula} ")
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
			end
		end
		return matriz_str
	end

end
