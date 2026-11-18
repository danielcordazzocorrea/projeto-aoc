.data
msg_invalida: .asciiz ": velocidade invalida\n"
msg_l_invalido: .asciiz ": valor invalido.\n"
msg_resultado: .asciiz "Maior nivel: velocidade "
quebra: .asciiz "\n"

.text
.globl main
main:
    li $v0, 5
    syscall
    move $s0, $v0

    blt $s0, 1, quantidade_invalida
    bgt $s0, 30, quantidade_invalida

    li $s1, 0
    li $t0, 0

ler_velocidade:
    beq $t0, $s0, mostrar_resultado

    li $v0, 5
    syscall
    move $t1, $v0

    blt $t1, 1, velocidade_invalida
    bgt $t1, 50, velocidade_invalida

    ble $t1, $s1, proxima
    move $s1, $t1
    j proxima

velocidade_invalida:
    move $a0, $t1
    li $v0, 1
    syscall

    la $a0, msg_invalida
    li $v0, 4
    syscall

proxima:
    addi $t0, $t0, 1
    j ler_velocidade

mostrar_resultado:
    li $t2, 1
    blt $s1, 10, imprimir

    li $t2, 2
    blt $s1, 20, imprimir

    li $t2, 3

imprimir:
    la $a0, msg_resultado
    li $v0, 4
    syscall

    move $a0, $t2
    li $v0, 1
    syscall

    la $a0, quebra
    li $v0, 4
    syscall
    j fim

quantidade_invalida:
    move $a0, $s0
    li $v0, 1
    syscall

    la $a0, msg_l_invalido
    li $v0, 4
    syscall

fim:
    li $v0, 10
    syscall