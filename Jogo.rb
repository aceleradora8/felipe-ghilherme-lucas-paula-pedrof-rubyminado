require 'colorize'
load "Campo.rb"

class Jogo
	attr_accessor :campo_jogo
	attr_accessor :bombas_marcadas
	attr_accessor :resultado

	def initialize(x, y)
		@flags_erradas = []
		@bombas_marcadas = []
		@campo_jogo = Campo.new(x, y)
		@resultado = 0 
	end

	def jogada(x, y, flag)
		eh_bomba = @campo_jogo.campo[x][y] == "☢".red
		eh_aberto = @campo_jogo.campo[x][y] == "■".black
		eh_flag = @campo_jogo.campo[x][y] == "■".yellow
		if flag == "y" and !eh_aberto and !eh_flag
			if eh_bomba #*
				@bombas_marcadas.push([x,y])
				if @bombas_marcadas.length == @campo_jogo.bombas
					@resultado = 1
					bombas_c_flag
					campo_jogo.mostra_campo_revelado
					puts "Fim de jogo, voce venceu! :D"
				end
			else 
				@flags_erradas.push([x,y])
			end
			@campo_jogo.campo[x][y] = "■".yellow
		elsif !eh_bomba and !eh_flag and !eh_aberto
			@campo_jogo.campo[x][y] = "■".black
		else # eh_bomba
			@resultado = 2
			bombas_c_flag
			flag_erro
			campo_jogo.mostra_campo_revelado
			puts "Fim de jogo, voce perdeu! :("
		end
	end

	# Valida parametros do teclado
	def verifica_parametros(x, y, flag)
		validacao = true
		if x > @campo_jogo.campo[0].length or y > @campo_jogo.campo.length 
			puts "Coordenada invalida, jogue novamente"
			puts
			validacao = false
		elsif flag != "y" and flag != "n"
			puts "Flag invalida, digite [y] para sim ou [n] para nao"
			puts
			validacao = false
		end
		return validacao
	end
	
	#descobre bombas com flag 
	def bombas_c_flag()
		@bombas_marcadas.each do |linha|
			coordx = linha[0]
			coordy = linha[1]
			@campo_jogo.campo[coordx][coordy] = "☢".yellow
		end
	end

	#descobre flags marcadas em lugares errados
	def flag_erro()
		@flags_erradas.each do |linha|
			coordx = linha[0]
			coordy = linha[1]
			@campo_jogo.campo[coordx][coordy] = "X".red
		end
	end
end
