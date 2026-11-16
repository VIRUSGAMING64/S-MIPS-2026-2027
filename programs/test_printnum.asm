.data
potencias: .word 1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1, 0

.text

addi $a0, $zero, 0
jal imprimir_entero

addi $a0, $zero, 1
jal imprimir_entero

addi $a0, $zero, 2
jal imprimir_entero

addi $a0, $zero, 3
jal imprimir_entero

addi $a0, $zero, 4
jal imprimir_entero

addi $a0, $zero, 5
jal imprimir_entero

addi $a0, $zero, 6
jal imprimir_entero

addi $a0, $zero, 7
jal imprimir_entero

addi $a0, $zero, 8
jal imprimir_entero

addi $a0, $zero, 9
jal imprimir_entero

addi $a0, $zero, 10
jal imprimir_entero

addi $a0, $zero, 11
jal imprimir_entero

addi $a0, $zero, 13
jal imprimir_entero

addi $a0, $zero, 15
jal imprimir_entero

addi $a0, $zero, 17
jal imprimir_entero

addi $a0, $zero, 19
jal imprimir_entero

addi $a0, $zero, 20
jal imprimir_entero

addi $a0, $zero, 22
jal imprimir_entero

addi $a0, $zero, 23
jal imprimir_entero

addi $a0, $zero, 24
jal imprimir_entero

addi $a0, $zero, 25
jal imprimir_entero

addi $v0, $zero, 10
syscall

# imprime $a0 en decimal: para cada potencia de 10 cuenta cuantas veces se puede restar
imprimir_entero:
        add  $t0, $a0, $zero
        slt  $t1, $t0, $zero
        beq  $t1, $zero, ie_positivo
        addi $a0, $zero, 45          # '-'
        addi $v0, $zero, 11
        syscall
        sub  $t0, $zero, $t0
ie_positivo:
        la   $t2, potencias
        add  $t4, $zero, $zero       # t4 = 1 cuando ya se imprimio un digito
ie_potencia:
        lw   $t3, 0($t2)
        beq  $t3, $zero, ie_fin
        add  $t5, $zero, $zero       # digito
ie_resta:
        slt  $t1, $t0, $t3
        bne  $t1, $zero, ie_digito
        sub  $t0, $t0, $t3
        addi $t5, $t5, 1
        j    ie_resta
ie_digito:
        addi $t1, $zero, 1
        beq  $t3, $t1, ie_imprime    # las unidades siempre se imprimen
        bne  $t5, $zero, ie_imprime
        beq  $t4, $zero, ie_siguiente # ceros a la izquierda: no
ie_imprime:
        addi $t4, $zero, 1
        addi $a0, $t5, 48
        addi $v0, $zero, 11
        syscall
ie_siguiente:
        addi $t2, $t2, 4
        j    ie_potencia
ie_fin: jr   $ra
