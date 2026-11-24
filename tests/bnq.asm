# Test mínimo de bne (tomado + no tomado) + beq (tomado)
# Debe imprimir exactamente: A
# y luego hacer HALT.

        .text
        .globl main

main:   add   $a2, $zero, $zero      # a2 = 0
        addi  $a1, $zero, -10        # a1 = -10

loop:   addi  $a2, $a2, -1           # a2--
        bne   $a1, $a2, loop         # mientras a1 != a2  (debe dar 10 vueltas)

        # Aquí a1 == a2 == -10  →  bne no tomado (correcto)
        addi  $a0, $zero, 65         # 'A'
        addi  $v0, $zero, 11
        syscall

        # Ahora comprobamos que beq también funciona cuando son iguales
        beq   $a1, $a2, fin          # debe saltar
        # Si llega aquí es que beq falló
        addi  $a0, $zero, 33         # '!'
        addi  $v0, $zero, 11
        syscall

fin:    addi  $v0, $zero, 10
        syscall
