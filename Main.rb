require 'colorize'
load "Campo.rb"
load "Jogo.rb"

puts "Digite o tamanho do campo em (x): " 
x = gets.to_i
puts "Digite o tamanho do campo em (y): " 
y = gets.to_i

jogo = Jogo.new(x, y)

system("clear")
puts jogo.campo.campo_oculto_str() # printa campo no terminal

while true
	puts "Digite a coordenada da jogada (x):"
	coord_x = gets.to_i
	puts "Digite a coordenada da jogada (y):"
	coord_y = gets.to_i
	puts "E flag? (y/n)"
	flag = gets.chomp

	if jogo.verifica_parametros(coord_x, coord_y, flag)
		jogo.jogada(coord_x, coord_y, flag)
	end

	if jogo.resultado == 1 or jogo.resultado == 2
		break
	else
		system("clear")
		puts jogo.campo.campo_oculto_str()
	end
end