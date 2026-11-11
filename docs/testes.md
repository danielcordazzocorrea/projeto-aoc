# Testes reproduzíveis

Execução observada com MARS 4.5 no modo de linha de comando (`java -jar Mars4_5.jar nc src/arena.asm`), configuração padrão e delayed branching desativado. Em cada caso, inicie uma nova execução e digite uma entrada por linha.

## 1. Uso normal: vitória

**Entradas:** `1, 1, 1, 1, 1, 1, 1, 1, 1`.

**Esperado:** os jogadores atacam alternadamente. O jogador 1 realiza o quinto ataque primeiro; robô 2 fica com zero de vida e o jogador 1 vence.

**Observado:** o MARS exibiu `Robo 2 | Vida: 0` e `VENCEDOR: jogador 1`. Os ataques reduziram a energia de cada atacante em 10.

**Justificativa:** o jogador 1 age nos turnos ímpares e seus cinco ataques causam 100 de dano.

## 2. Entrada inválida e defesa

**Entradas:** `abc, 12, 4, 2, 1, 3, 0`.

**Esperado:** três mensagens de ação inválida sem perder o turno. O jogador 1 ativa defesa; o ataque seguinte do jogador 2 causa 10 de dano. A partida termina com `0`.

**Observado:** o MARS exibiu três vezes `Acao invalida. Tente novamente.`, depois `Ataque realizado! Dano: 10` e `Partida encerrada pelo jogador.`

**Justificativa:** `read_choice` rejeita texto, entradas com mais de um caractere e números fora do menu. `attack` consome a defesa do alvo e reduz o dano de 20 para 10.

## 3. Limite de energia

**Entradas:** `1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 3, 0`.

**Esperado:** após cinco ataques do jogador 1, sua energia chega a zero. A sexta tentativa de ataque é rejeitada sem trocar de jogador. Em seguida ele recarrega 20 de energia, e o jogador 2 encerra a partida.

**Observado:** o MARS exibiu `Robo 1 | Vida: 100 | Energia: 0`, `Robo 2 | Vida: 40`, `Energia insuficiente! Escolha outra acao.` e, após a recarga, devolveu a vez ao jogador 2.

**Justificativa:** o primeiro ataque causa 20; os quatro seguintes encontram defesa e causam 10 cada. Cinco ataques consomem exatamente os 50 pontos de energia iniciais.
