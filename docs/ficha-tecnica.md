# Ficha técnica — Arena MIPS

## Produto e lógica

Dois jogadores controlam robôs por turnos no MARS. O programa mostra o placar, lê uma ação, valida a escolha, atualiza vida, energia ou defesa e alterna o jogador. Ao reduzir a vida adversária a zero, anuncia o vencedor. A entrada `0` encerra antecipadamente.

## Requisitos técnicos

| Requisito | Localização no código |
| --- | --- |
| Entrada e saída | `read_choice`, `print_string`, `print_int`, `show_status` |
| Decisões e repetição | `game_loop`, seleção de ação, `status_loop`, cálculo de dano e energia |
| Vetor de dados | `life`, `energy` e `defense`, com dois elementos `.word` cada |
| Procedimentos com parâmetros e retornos | `attack`, `defend`, `recharge` recebem índice em `$a0`; `attack` retorna sucesso em `$v0`; `read_choice` retorna escolha em `$v0` |
| Preservação e pilha | `show_status` e `attack` salvam `$ra` e os registradores `$s` usados antes de chamar outros procedimentos |
| Entradas inválidas e saída | `read_choice` aceita só um dígito de `0` a `3`; `invalid_action`, `attack_no_energy`, `quit_game` |

O índice do jogador é `0` ou `1`; o deslocamento no vetor é calculado com `sll índice, 2`. `current` guarda o jogador ativo. A defesa é um sinalizador consumido somente quando um ataque atinge o robô. A vida nunca fica abaixo de zero, e a energia nunca passa de 50.

**Contagem:** 216 linhas úteis de instruções em `src/arena.asm`, contando uma instrução ou pseudoinstrução por linha e excluindo diretivas, comentários, rótulos e linhas em branco. A lógica central está em `attack`, `defend`, `recharge`, `game_loop` e `after_action`.

## Grupo e acompanhamento

- Integrante único: **Daniel Cordazzo Correa**. Responsável pelo desenvolvimento, revisão do código, testes, documentação e apresentação do projeto. O apoio do Codex está registrado em `docs/uso-ia.md`.
- Feedback da professora: **ainda não recebido**, pois o projeto está na fase inicial. Ajustes decorrentes de feedback serão registrados aqui quando houver.
- Limitação conhecida: dois jogadores locais; sem IA adversária ou interface gráfica.
