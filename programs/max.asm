.data
    potencias: .word 1000000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10, 1, 0
    array: .byte 1,7,4,3,1,2,9,5,4,2
    size: .byte 10

.text
    la $t0, size
    lbu $s0, 0($t0)
    la $a0, array
    li $t2, 0
loop:
    beq $s0, $t2, end
    lbu $t0, 0($a0)
    slt $t3, $t0, $s1
    beq $t3, $zero, update # poner en S1 el valor de T0
    

loopcon:
    addi $a0, $a0, 1
    addi $t2, $t2, 1
    j loop

update:
    addi $s1, $t0, 0
    j loopcon

imprimir_entero:
        add  $t0, $a0, $zero
        la   $t2, potencias
        add  $t4, $zero, $zero
ie_potencia:
        lw   $t3, 0($t2)
        beq  $t3, $zero, ie_fin
        add  $t5, $zero, $zero
ie_resta:
        slt  $t1, $t0, $t3
        bne  $t1, $zero, ie_digito
        sub  $t0, $t0, $t3
        addi $t5, $t5, 1
        j    ie_resta
ie_digito:
        addi $t1, $zero, 1
        beq  $t3, $t1, ie_imprime
        bne  $t5, $zero, ie_imprime
        beq  $t4, $zero, ie_siguiente
ie_imprime:
        addi $t4, $zero, 1
        addi $a0, $t5, 48
        addi $v0, $zero, 11
        syscall
ie_siguiente:
        addi $t2, $t2, 4
        j    ie_potencia
ie_fin: jr   $ra

end:
    addi $a0, $s1, 0
    jal imprimir_entero
    li $v0, 10
    syscall
    li $v0, 11
    syscall
