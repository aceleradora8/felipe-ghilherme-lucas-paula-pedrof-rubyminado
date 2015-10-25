require 'colorize'
# matriz = [["l0c0","l1c1", l1]]
class Campo 
	attr_reader :array_bombas				# array de coordenadas das bombas
	attr_reader :array_bandeiras	# array de coordenadas das bandeiras
	attr_reader :matriz						# matriz de representação do campo
 
 	# construtor
	def initialize(num_linhas, num_colunas)
		@bomba_figura = "B"
		@celula_figura = "#"
		@bandeira_figura = "F"
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
				@matriz[i][j] = @celula_figura
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
				@matriz[bomba_linha][bomba_coluna] = @bomba_figura
				bombas_criadas += 1
			end
		end
	end

	# escreve o valor de marcacao na a posicao (linha,coluna) da matriz
	# A FAZER: algoritmo de encadeamento (provalvemente vai nesse metodo)
	def marca_campo!(marcacao, linha, coluna)
		if marcacao == @bandeira_figura
			@array_bandeiras.push([linha, coluna])
		else
			@matriz[linha][coluna] = marcacao
		end
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
				matriz_str += (celula == @bomba_figura ? "#{@celula_figura} " : "#{celula} ")
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
				matriz_str += "#{@matriz[i][j]} "
			end
		end
		return matriz_str
	end

end
