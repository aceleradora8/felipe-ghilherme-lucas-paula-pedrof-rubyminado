# RubyMinado

RubyMinado é um jogo baseado no famoso "Campo Minado" (ou Minesweeper) feito em Ruby e executado pelo Terminal. O jogador começa escolhendo a dificuldade do jogo (tamanho do campo) e procede a tentar resolver o jogo através de jogadas lidas do teclado.

## Passo a passo de como jogar

1. Executar Main.rb pelo Terminal `ruby Main.rb`
2. Jogador define o tamanho do campo (número de linhas e colunas)
  * Exemplo de comando para criar um jogo com 10 linhas e 10 colunas: `10 10`
3. Jogador passa uma coordenada e uma indicação para uma jogada de bandeira
  * A indicação de bandeira aceita apenas duas opções: "s" para SIM ou "n" para NÃO. Exemplo de comando para uma jogada de bandeira na linha 0 e coluna 4 : `0 4 s`
4. Repetir passo 3 até o jogo acabar

## Considerações

Projeto feito durante período de estudos de Ruby da turma 8 da Aceleradora Ágil da ThoughtWorks, Rubiteam, 2015.
Contribuidores: Felipe Rodrigues (@feliperdius) Paula Bol (@pauladbol) e Pedro Fontoura (@pedrofontoura)
