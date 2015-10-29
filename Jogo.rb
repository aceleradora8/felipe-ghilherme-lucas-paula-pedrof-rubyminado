require 'colorize'
load "Campo.rb"
load "Icones.rb"

class Jogo

	attr_reader :campo

	def initialize(num_linhas, num_colunas)
		@campo = Campo.new(num_linhas, num_colunas)
	end

	# executa uma jogada (altera @campo)
	# retorna 0 (jogada invalida) 1 (jogo nao acabou) 2 (venceu) 3 (perdeu)
	def jogada!(linha, coluna, flag)
		resposta = 0
		eh_aberto = @campo.matriz[linha][coluna] == Icones::CELULA_ABERTA
		eh_bomba = @campo.matriz[linha][coluna] == Icones::BOMBA
		eh_flag = @campo.array_bandeiras.include?([linha, coluna])
		if flag == "y" # jogada eh flag
			unless eh_aberto
				@campo.marca_campo!(Icones::BANDEIRA, linha, coluna)
				resposta = 1
			end
		else # jogada nao eh flag
			if eh_bomba
				resposta = 3
			else # jogada normal
				resposta = (eh_flag || eh_aberto ? 0 : 1)
				@campo.marca_campo!(Icones::CELULA_ABERTA, linha, coluna) if resposta == 1
			end
		end
		return resposta
	end

	# valida parametros do teclado
	# Retorna 0 (invalido) ou 1 (valido)
	#def valida_parametros(coord_linha, coord_coluna, flag)
	#	return (coord_linha >= 0 && coord_linha < @campo.matriz.length) && (coord_coluna >= 0 && coord_coluna < @campo.matriz[0].length) && (flag == "y" || flag == "n") ? 1 : 0
	#end

end