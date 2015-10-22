require 'colorize'
load "Campo.rb"

class Jogo
		attr_accessor :campo_jogo

		def initialize(x, y)
			@campo_jogo = Campo.new(x, y)
		end

		def jogada(x, y, flag)
			if flag == "y"
				@campo_jogo.campo[x][y] = "■".yellow
			else
				@campo_jogo.campo[x][y] = "■".black
			end
		end
		
end
