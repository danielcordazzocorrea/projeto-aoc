# Arena MIPS — Duelo de Robôs por Turnos

Jogo local para dois jogadores em Assembly MIPS. Cada robô começa com 100 de vida e 50 de energia. Em cada turno, o jogador escolhe atacar, defender, recarregar ou encerrar. A partida termina quando a vida de um robô chega a zero.

Repositório: https://github.com/danielcordazzocorrea/projeto-aoc

**Autor:** Daniel Cordazzo Correa (projeto individual).

## Executar

1. Abra o MARS 4.5 e carregue `src/arena.asm` em **File > Open**.
2. Use a configuração padrão de memória e deixe **Settings > Delayed Branching** desativado.
3. Clique em **Assemble** e depois em **Run**. Digite as escolhas na aba **Run I/O**, uma por linha.

Também é possível executar pelo terminal: `java -jar CAMINHO_PARA_MARS.jar nc src/arena.asm`.

## Comandos

| Entrada | Ação |
| --- | --- |
| `1` | Ataca: gasta 10 de energia e causa 20 de dano. Se o alvo estiver defendendo, causa 10 e consome a defesa. |
| `2` | Defende: reduz pela metade o próximo ataque recebido. |
| `3` | Recarrega: ganha até 20 de energia, respeitando o máximo de 50. |
| `0` | Encerra a partida. |

Escolhas inválidas e ataques sem energia repetem o turno. A defesa permanece ativa até receber um ataque; defender novamente apenas mantém esse estado.

## Estrutura e entrega

- `src/arena.asm`: arquivo principal e interface textual no console do MARS.
- `docs/ficha-tecnica.md`: organização da lógica e requisitos MIPS.
- `docs/testes.md`: três casos reproduzíveis.
- `docs/uso-ia.md`: registro do apoio de IA e sua verificação.

Versão testada: MARS 4.5, configuração padrão de memória, delayed branching desativado. A interface atual é textual no console. O jogo não tem adversário automático, som ou animações.

**Situação da entrega:** o projeto já pode ser demonstrado no MARS. Ainda não houve feedback da professora. O vídeo final ainda não foi gravado; seu link será incluído aqui quando estiver disponível.

