# Test mínimo de pila + jal/jr
# Debe imprimir: OK
        .text
main:   addi $sp, $sp, -8
        addi $t0, $zero, 0x1234
        sw   $t0, 4($sp)
        sw   $ra, 0($sp)          # guardar ra
        jal  func
        # si volvemos aquí correctamente:
        lw   $t1, 4($sp)
        lui  $t2, 0
        ori  $t2, $t2, 0x1234
        beq  $t1, $t2, ok
        addi $a0, $zero, 88       # 'X'
        j    print
ok:     addi $a0, $zero, 79       # 'O'
print:  addi $v0, $zero, 11
        syscall
        addi $a0, $zero, 75       # 'K'
        syscall
        addi $v0, $zero, 10
        syscall

func:   addi $a0, $zero, 0        # no hace nada
        jr   $ra
