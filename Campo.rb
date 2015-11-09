require 'colorize'
load 'Icones.rb'

class Campo 
	attr_reader :matriz          # matriz de representação do campo
	attr_reader :array_bandeiras # array de coordenadas das bandeiras
	attr_reader :array_bombas    # array de coordenadas das bombas
 
	def initialize(num_linhas, num_colunas)
		total_bombas = (num_linhas * num_colunas) / 8
		@array_bombas = cria_array_bombas(total_bombas, num_linhas, num_colunas)
		@array_bandeiras = Array.new
		@matriz = cria_matriz(num_linhas, num_colunas)
	end
	
	# inicializa e retorna a matriz do jogo
	def cria_matriz(num_linhas, num_colunas)
		matriz = Array.new(num_linhas) { Array.new(num_colunas) }
		for i in 0..matriz.length-1 do
			for j in 0..matriz[i].length-1 do
				matriz[i][j] = @array_bombas.include?([i,j]) ? Icones::BOMBA : Icones::CELULA
			end
		end
		return matriz
	end

	# cria e retorna um array com as coordenadas das bombas
	def cria_array_bombas(total_bombas, num_linhas, num_colunas)
		array_bombas = Array.new(total_bombas)
		bombas_criadas = 0
		while bombas_criadas < total_bombas do
			bomba_linha = Random.rand(num_linhas)
			bomba_coluna = Random.rand(num_colunas)
			coord_bomba = [bomba_linha, bomba_coluna]
			unless array_bombas.include?(coord_bomba)
				array_bombas.push(coord_bomba)
				bombas_criadas += 1
			end
		end
		return array_bombas
	end

	# escreve o valor de marcacao na a coordenada (linha,coluna) da matriz
	def marca_campo!(marcacao, linha, coluna)
		if marcacao == Icones::BANDEIRA
			@array_bandeiras.push([linha, coluna])
		else
			numero_celula = numero_bombas_ao_redor(linha, coluna)
			if(numero_celula > 0)
				@matriz[linha][coluna] = numero_celula.to_s
			else
				@matriz[linha][coluna] = Icones::CELULA_ABERTA
				#revela_em_massa!(linha, coluna)
			end
		end
	end

	# verifica se uma celula é bomba
	def eh_bomba?(coord_linha, coord_coluna)
		coord_validas = coordenadas_validas?(coord_linha, coord_coluna)
		eh_bomba = @matriz[coord_linha][coord_coluna] == Icones::BOMBA if coord_validas
		return eh_bomba
	end

	# verifica se uma celula é aberta
	def eh_aberto?(coord_linha, coord_coluna)
		coord_validas = coordenadas_validas?(coord_linha, coord_coluna)
		eh_aberto = @matriz[coord_linha][coord_coluna] == Icones::CELULA_ABERTA if coord_validas
		return eh_aberto
	end

	# verifica se uma celula é bandeira
	def eh_bandeira?(coord_linha, coord_coluna)
		return @array_bandeiras.include?([coord_linha, coord_coluna])
	end

	# retorna uma String formatada do campo com as bombas ocultadas
	def campo_oculto_str()
		matriz_str = cria_string_indices

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
		matriz_str = cria_string_indices

		for i in 0..@matriz.length-1 do
			matriz_str += "\n#{i} "
			for j in 0..@matriz[i].length-1 do
				indice_celula = numero_bombas_ao_redor(i,j)
				if @array_bandeiras.include?([i,j])
					matriz_str += "#{Icones::BANDEIRA} "
				elsif indice_celula > 0
					matriz_str += "#{indice_celula} "
				else
					matriz_str += "#{matriz[i][j]} "
				end
			end
		end
		return matriz_str
	end

	# verifica se uma coordenada é valida nas definições da matriz
	def coordenadas_validas?(coord_linha, coord_coluna)
		return (coord_linha >= 0 && coord_linha < @matriz.length) && (coord_coluna >= 0 && coord_coluna < @matriz[0].length)
	end

	# cria e retorna o numero de bombas ao redor da celula na coordenada (linha, coluna)
	def numero_bombas_ao_redor(linha, coluna)
		numero = 0
		unless(@matriz[linha][coluna] == Icones::BOMBA)
			numero +=1 if eh_bomba?(linha, coluna-1)
			numero +=1 if eh_bomba?(linha, coluna+1)
			numero +=1 if eh_bomba?(linha-1, coluna)
			numero +=1 if eh_bomba?(linha+1, coluna)
			numero +=1 if eh_bomba?(linha-1, coluna+1)
			numero +=1 if eh_bomba?(linha+1, coluna-1)
			numero +=1 if eh_bomba?(linha+1, coluna+1)
			numero +=1 if eh_bomba?(linha-1, coluna-1)
		end
		return numero
	end

	# cria e retorna uma linha com os indices das linhas da matriz
	def cria_string_indices()
		indices = " "
		for i in 0..@matriz[0].length-1 do
			indices += " #{i}"
		end
		return indices
	end

	private :coordenadas_validas?, :cria_string_indices, :numero_bombas_ao_redor, :cria_array_bombas, :cria_matriz

end
