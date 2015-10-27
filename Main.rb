require 'colorize'
load "Campo.rb"
load "Jogo.rb"

puts "Digite o tamanho do campo Ex.: [1 2]: "
	comandos = gets.chomp.split(" ")
	num_lins = comandos[0].to_i
	num_cols = comandos[1].to_i

jogo = Jogo.new(num_lins, num_cols)

while true
	system("clear")
	puts jogo.campo.campo_revelado_str()
	puts jogo.campo.campo_oculto_str()

	puts "Digite a jogada Ex.: [1 2 y]: "
	comandos = gets.chomp
	linha = comandos[0].to_i
	coluna = comandos[2].to_i
	flag = comandos[4]

	if jogo.valida_parametros(linha, coluna, flag) == 1
		jogada = jogo.jogada!(linha, coluna, flag)
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