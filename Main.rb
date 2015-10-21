require 'colorize'
load "Campo.rb"
load "Jogo.rb"
puts "Digite o tamanho do campo em (x): " 
x = gets.to_i
puts "Digite o tamanho do campo em (y): " 
y = gets.to_i

jogo = Jogo.new(x, y)


jogo.campo_jogo.mostra_campos()

while true
	puts "Digite a coordenada da jogada (x):"
	coord_x = gets.to_i
	puts "Digite a coordenada da jogada (y):"
	coord_y = gets.to_i
	puts "É flag? (y/n)"
	flag = gets.chomp

	jogo.jogada(coord_x, coord_y, flag)
	jogo.campo_jogo.mostra_campos()
end


system "clear"

jogo.campo_jogo.mostra_campos()
