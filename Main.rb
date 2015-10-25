require 'colorize'
load "Campo.rb"
load "Jogo.rb"

puts "Digite o número de linhas do campo: " 
num_lin = gets.to_i
puts "Digite o número de colunas do campo: " 
num_col = gets.to_i

jogo = Jogo.new(num_lin, num_col)

system("clear")
puts jogo.campo.campo_revelado_str() # printa campo no terminal

while true
	puts "Digite o índice da linha: "
	linha = gets.to_i
	puts "Digite o índice da coluna:"
	coluna = gets.to_i
	puts "E flag? (y/n)"
	flag = gets.chomp

	system("clear")
	if jogo.valida_parametros(linha, coluna, flag) == 1
		jogada = jogo.jogada!(linha, coluna, flag)
		puts jogo.campo.campo_oculto_str
		case jogada
		when 0
			puts "Jogada invalida!"
		when 2
			puts "Game Over. Você ganhou!"
			break
		when 3
			puts "Game Over. Você perdeu!"
			break
		end
	else
		puts "Valores invalidos!"
	end

end
