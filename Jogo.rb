require 'colorize'
load "Campo.rb"

class Jogo
	attr_accessor :campo
	attr_accessor :bombas_marcadas
	attr_accessor :resultado

	def initialize(x, y)
		@flags_erradas = []
		@bombas_marcadas = []
		@campo = Campo.new(x, y)
		@resultado = 0 
		#@icones = Icones.new()
	end

	#
	# retorna 1 (venceu) 2 (perdeu) ou 0 (ainda nao acabou)
	def jogada(x, y, flag)
		eh_bomba = @campo.matriz[x][y] == "☢".red
		eh_aberto = @campo.matriz[x][y] == "■ ".black
		eh_flag = @campo.matriz[x][y] == "■ ".yellow
		if flag == "y" and !eh_aberto and !eh_flag
			if eh_bomba
				@bombas_marcadas.push([x,y])
				#if @bombas_marcadas.length == @campo_jogo.bombas
					#@resultado = 1
					#bombas_c_flag
					#campo_jogo.mostra_campo_revelado
					#puts "Fim de jogo, voce venceu! :D"
			else 
				@flags_erradas.push([x,y])
			end
			@campo.matriz[x][y] = "■ ".yellow # marca flag
		elsif !eh_bomba and !eh_flag and !eh_aberto
			@campo.matriz[x][y] = "■ ".black
		else # eh_bomba
		end
	end

	# Valida parametros do teclado
	# Retorna 1 (valido) ou 2 (invalido)
	def verifica_parametros(x, y, flag)
		validacao = true
		if x > @campo.matriz[0].length or y > @campo.matriz.length 
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
			@campo.matriz[coordx][coordy] = "☢".yellow
		end
	end

	#descobre flags marcadas em lugares errados
	def flag_erro()
		@flags_erradas.each do |linha|
			coordx = linha[0]
			coordy = linha[1]
			@campo.matriz[coordx][coordy] = "X".red
		end
	end
end
