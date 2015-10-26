require 'colorize'
load "Campo.rb"
load "Icones.rb"

class Jogo

	attr_reader :campo

	# construtor
	def initialize(linhas, colunas)
		@campo = Campo.new(linhas, colunas)
	end

	# executa uma jogada (altera @campo)
	# retorna 0 (jogada invalida) 1 (jogo nao acabou) 2 (venceu) 3 (perdeu)
	def jogada!(linha, coluna, flag)
		eh_aberto = @campo.matriz[linha][coluna] == Icones::CELULA_ABERTA
		eh_bomba = @campo.matriz[linha][coluna] == Icones::BOMBA
		eh_flag = @campo.array_bandeiras.include?([linha, coluna])
		if flag == "y" # jogada eh flag
			if eh_aberto
				return 0
			else
				@campo.marca_campo!(Icones::BANDEIRA, linha, coluna)
				return 1
			end
		else # jogada nao eh flag
			if eh_bomba
				return 3
			elsif eh_flag or eh_aberto
				return 0
			else # jogada normal
				@campo.marca_campo!(Icones::CELULA_ABERTA, linha, coluna)
				return 1
			end
		end
	end

	# valida parametros do teclado
	# Retorna 0 (invalido) ou 1 (valido)
	def valida_parametros(linha, coluna, flag)
		return (linha >= @campo.matriz[0].length || coluna >= @campo.matriz.length || (flag != "y" && flag != "n") ? 0 : 1)
	end

end