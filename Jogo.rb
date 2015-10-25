require 'colorize'
load "Campo.rb"

class Jogo

	attr_reader :campo

	# construtor
	def initialize(linhas, colunas)
		@aberto_figura = "A"
		@bomba_figura = "B"
		@bandeira_figura = "F"
		@campo = Campo.new(linhas, colunas)
	end

	# executa uma jogada (altera @campo)
	# retorna 0 (jogada invalida) 1 (jogo nao acabou) 2 (venceu) 3 (perdeu)
	def jogada!(linha, coluna, flag)
		eh_aberto = @campo.matriz[linha][coluna] == @aberto_figura
		eh_bomba = @campo.matriz[linha][coluna] == @bomba_figura
		eh_flag = @campo.matriz[linha][coluna] == @bandeira_figura
		if flag == "y" # jogada eh flag
			unless eh_aberto
				@campo.marca_campo!(@bandeira_figura, linha, coluna)
				return 1
			else
				return 0
			end
		else # jogada nao eh flag
			if eh_bomba
				return 3
			elsif eh_flag or eh_aberto
				return 0
			else # jogada normal
				@campo.marca_campo!(@aberto_figura, linha, coluna)
				return 1
			end
		end
	end

	# valida parametros do teclado
	# Retorna 0 (invalido) ou 1 (valido)
	def valida_parametros(linha, coluna, flag)
		validacao = (linha >= @campo.matriz[0].length or coluna >= @campo.matriz.length or (flag != "y" and flag != "n") ? 0 : 1)
		return validacao
	end

end
