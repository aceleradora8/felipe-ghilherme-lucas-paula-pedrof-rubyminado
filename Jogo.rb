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
	def jogada!(coord_linha, coord_coluna, indicacao_bandeira)
		resposta = 0
		eh_aberto = @campo.eh_aberto?(coord_linha, coord_coluna)
		eh_bomba = @campo.eh_bomba?(coord_linha, coord_coluna)
		eh_bandeira = @campo.eh_bandeira?(coord_linha, coord_coluna)
		if indicacao_bandeira == "y" # jogada eh flag
			unless eh_aberto
				@campo.marca_campo!(Icones::BANDEIRA, linha, coluna)
				resposta = 1
			end
		else # jogada nao eh flag
			if eh_bomba
				resposta = 3
			else # jogada normal
				resposta = (eh_bandeira || eh_aberto ? 0 : 1)
				@campo.marca_campo!(Icones::CELULA_ABERTA, linha, coluna) if resposta == 1
			end
		end
		return resposta
	end

end