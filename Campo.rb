require 'colorize'

class Campo 
	attr_accessor :array_bombas # array de coordenadas bombasticas
	attr_accessor :matriz

	# CONSTRUTOR
	# 
	def initialize(num_linhas, num_colunas)
		@array_bombas = []
		@matriz = []
		gera_campo!(num_linhas, num_colunas)
	end
	
	# 
	def gera_campo!(num_linhas, num_colunas)
		num_colunas.times { @matriz.push([]) } # [[],[],[],[]]
		pos = 0
		@matriz.each do |coluna|
			while pos < num_linhas
				coluna.push("#")
				pos += pos
			end
		end
		gera_bombas!()
	end

	def gera_bombas!()
		linha = Random.rand(@matriz.length)
		coluna = Random.rand(@matriz.length)
		array = [linha, coluna]
		cont = 0

		while cont < linha do
			unless array_bombas.include? array
				array_bombas.push(array)
				cont += cont
			end
		end

		@matriz.each do |pares|
			linha = pares[0]
			coluna = pares[1]
			@matriz[linha][coluna] = "B"
		end

	end

	#
	def index_colunas_str()
		index_colunas = " "
		contador = 0
		@matriz.length.times do
			index_colunas.concat(" #{contador}")
			contador += 1
		end
		return index_colunas
	end
	private :index_colunas_str

	def campo_oculto_str()
		campo_str = index_colunas_str()
		index_linhas = 0
		bomba = "☢".red
		celula_oculta = "■ "
		@matriz.each do |coluna|
			campo_str.concat("\n#{index_linhas} ")
			index_linhas += 1
			coluna.each do |celula|
				if(celula == bomba)
					campo_str.concat(celula_oculta)
				else
					campo_str.concat(celula)
				end
			end
		end
		return campo_str
	end

	def campo_revelado_str()
		campo_str = index_colunas_str()
		index_linhas = 0
		@matriz.each do |coluna|
			campo_str.concat("\n#{index_linha} ")
			index_linha += 1
			coluna.each do |celula|
				campo_str.concat(celula)
			end
		end
		return campo_str
	end

end