# Test lw a $zero
# Debe imprimir: G
        .data
val:    .word 0x12345678

        .text
main:
        la   $t0, val
        lw   $zero, 0($t0)       # no debe escribir en $zero
        lw   $t1, 0($t0)         # debe seguir siendo 0x12345678
        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t1, $t2, ok
        addi $a0, $zero, 88      # 'X'
        j    print
ok:     addi $a0, $zero, 71      # 'G'
print:  addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall
