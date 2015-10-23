require 'colorize'

class Icones

	attr_accessor :hash

		def initialize() 
			@hash = { "BOMBA" => "☢", "CELULA" => "■ ", "BANDEIRA" => "■ b", "CELULA_ABERTA" => "■ a" }
		end

		def pega(str)
			return @hash[str]
		end

end