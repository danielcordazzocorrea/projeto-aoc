
.data
welcome: .asciiz "================================\n ARENA MIPS | DUELO DE ROBOS\n================================\nDois jogadores locais. Vida: 100 | Energia: 50\n"
turnMsg: .asciiz "\n>>> VEZ DO JOGADOR "
statusMsg: .asciiz "\n--------- PLACAR ---------\n"
robotMsg: .asciiz "Robo "
lifeMsg: .asciiz " | Vida: "
energyMsg: .asciiz " | Energia: "
defMsg: .asciiz " | Defesa: "
activeMsg: .asciiz "ATIVA"
inactiveMsg: .asciiz "inativa"
menuMsg: .asciiz "\n[1] Atacar    -10 energia, 20 dano\n[2] Defender  metade do proximo ataque\n[3] Recarregar +20 energia (max. 50)\n[0] Encerrar partida\nEscolha: "
invalidMsg: .asciiz "Acao invalida. Tente novamente.\n"
noEnergyMsg: .asciiz "Energia insuficiente! Escolha outra acao.\n"
attackMsg: .asciiz "Ataque realizado! Dano: "
defenseMsg: .asciiz "Defesa ativada para o proximo ataque recebido.\n"
chargeMsg: .asciiz "Energia recarregada.\n"
winMsg: .asciiz "\nVENCEDOR: jogador "
quitMsg: .asciiz "\nPartida encerrada pelo jogador.\n"
newline: .asciiz "\n"
inputBuffer: .space 64

# Atributos dos dois robos
life: .word 100, 100
energy: .word 50, 50
defense: .word 0, 0
current: .word 0

.text
.globl main

main:
    la $a0, welcome
    jal print_string

game_loop:
    jal show_status

    la $a0, turnMsg
    jal print_string

    lw $t0, current
    addiu $a0, $t0, 1
    jal print_int

    la $a0, menuMsg
    jal print_string

    jal read_choice
    move $t0, $v0

    beqz $t0, quit_game

    li $t1, 1
    beq $t0, $t1, choose_attack

    li $t1, 2
    beq $t0, $t1, choose_defense

    li $t1, 3
    beq $t0, $t1, choose_charge

    j invalid_action

choose_attack:
    lw $a0, current
    jal attack
    beqz $v0, game_loop
    j after_action

choose_defense:
    lw $a0, current
    jal defend
    j after_action

choose_charge:
    lw $a0, current
    jal recharge
    j after_action

invalid_action:
    la $a0, invalidMsg
    jal print_string
    j game_loop

after_action:
    lw $t0, current
    xori $t1, $t0, 1
    sll $t2, $t1, 2

    la $t3, life
    addu $t3, $t3, $t2
    lw $t4, 0($t3)

    blez $t4, announce_winner

    sw $t1, current
    j game_loop

announce_winner:
    jal show_status

    la $a0, winMsg
    jal print_string

    lw $t0, current
    addiu $a0, $t0, 1
    jal print_int

    la $a0, newline
    jal print_string
    j exit_program

quit_game:
    la $a0, quitMsg
    jal print_string

exit_program:
    li $v0, 10
    syscall

# Le uma linha e aceita apenas um unico digito de 0 a 3.
# Retorna -1 para texto, numero longo ou entrada fora do menu.
read_choice:
    la $a0, inputBuffer
    li $a1, 64
    li $v0, 8
    syscall

    la $t0, inputBuffer
    lbu $t1, 0($t0)
    li $t2, 48
    slt $t3, $t1, $t2
    bnez $t3, choice_invalid
    li $t2, 52
    slt $t3, $t1, $t2
    beqz $t3, choice_invalid

    lbu $t2, 1($t0)
    beqz $t2, choice_valid
    li $t3, 10
    bne $t2, $t3, choice_invalid

choice_valid:
    addiu $v0, $t1, -48
    jr $ra

choice_invalid:
    li $v0, -1
    jr $ra

# Procedimento para imprimir string
print_string:
    li $v0, 4
    syscall
    jr $ra

# Procedimento para imprimir inteiro
print_int:
    li $v0, 1
    syscall
    jr $ra

# Exibe os atributos dos dois robos
show_status:
    addiu $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    la $a0, statusMsg
    jal print_string

    li $s0, 0

status_loop:
    li $s1, 2
    beq $s0, $s1, status_done

    la $a0, robotMsg
    jal print_string

    addiu $a0, $s0, 1
    jal print_int

    la $a0, lifeMsg
    jal print_string

    sll $s1, $s0, 2
    la $t0, life
    addu $t0, $t0, $s1
    lw $a0, 0($t0)
    jal print_int

    la $a0, energyMsg
    jal print_string

    la $t0, energy
    addu $t0, $t0, $s1
    lw $a0, 0($t0)
    jal print_int

    la $a0, defMsg
    jal print_string

    la $t0, defense
    addu $t0, $t0, $s1
    lw $t1, 0($t0)
    beqz $t1, status_inactive
    la $a0, activeMsg
    j status_print_defense

status_inactive:
    la $a0, inactiveMsg

status_print_defense:
    jal print_string

    la $a0, newline
    jal print_string

    addiu $s0, $s0, 1
    j status_loop

status_done:
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addiu $sp, $sp, 12
    jr $ra

# Ataque: recebe indice do atacante em $a0
# Retorna 1 em $v0 se conseguiu atacar
attack:
    addiu $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    move $s0, $a0

    sll $t0, $s0, 2
    la $t1, energy
    addu $t1, $t1, $t0
    lw $t2, 0($t1)

    slti $t3, $t2, 10
    bnez $t3, attack_no_energy

    addiu $t2, $t2, -10
    sw $t2, 0($t1)

    xori $s1, $s0, 1
    sll $t0, $s1, 2

    la $t1, defense
    addu $t1, $t1, $t0
    lw $t2, 0($t1)

    li $t3, 20
    beqz $t2, attack_apply

    li $t3, 10
    sw $zero, 0($t1)

attack_apply:
    la $t1, life
    addu $t1, $t1, $t0
    lw $t2, 0($t1)

    subu $t2, $t2, $t3
    bgez $t2, attack_store
    move $t2, $zero

attack_store:
    sw $t2, 0($t1)

    la $a0, attackMsg
    jal print_string

    move $a0, $t3
    jal print_int

    la $a0, newline
    jal print_string

    li $v0, 1
    j attack_done

attack_no_energy:
    la $a0, noEnergyMsg
    jal print_string
    move $v0, $zero

attack_done:
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addiu $sp, $sp, 12
    jr $ra

# Ativa defesa do robo
defend:
    sll $t0, $a0, 2
    la $t1, defense
    addu $t1, $t1, $t0

    li $t2, 1
    sw $t2, 0($t1)

    la $a0, defenseMsg
    li $v0, 4
    syscall
    jr $ra

# Recarrega energia ate o limite de 50
recharge:
    sll $t0, $a0, 2
    la $t1, energy
    addu $t1, $t1, $t0

    lw $t2, 0($t1)
    addiu $t2, $t2, 20

    slti $t3, $t2, 51
    bnez $t3, recharge_store

    li $t2, 50

recharge_store:
    sw $t2, 0($t1)

    la $a0, chargeMsg
    li $v0, 4
    syscall
    jr $ra
