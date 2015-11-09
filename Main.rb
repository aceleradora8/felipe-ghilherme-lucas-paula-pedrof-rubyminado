require 'colorize'
load "Campo.rb"
load "Jogo.rb"

puts "Digite o tamanho do campo:"
	comando = gets.chomp.split(" ")
	num_lins = comando[0].to_i
	num_cols = comando[1].to_i

jogo = Jogo.new(num_lins, num_cols)
jogo_rodando = true

while jogo_rodando
	system("clear")
	puts jogo.campo.campo_revelado_str()
	puts
	puts jogo.campo.campo_oculto_str()

	puts "Digite o comando da jogada:"
	comando = gets.chomp
	linha = comando[0].to_i
	coluna = comando[2].to_i
	bandeira = comando[4]

	jogada = jogo.jogada!(linha, coluna, bandeira)
	case jogada
	when 0
		puts "Jogada invalida!"
	when 2
		puts "Game Over. Você ganhou!"
		jogo_rodando = false
	when 3
		puts "Game Over. Você perdeu!"
		jogo_rodando = false
	end

end