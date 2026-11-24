# Diagnóstico lw $zero
# Salida esperada: AG
        .data
val:    .word 0x12345678

        .text
main:
        la   $t0, val

        # Marca 1: llegamos aquí
        addi $a0, $zero, 65      # 'A'
        addi $v0, $zero, 11
        syscall

        lw   $zero, 0($t0)       # intento de escribir en $zero

        # Ahora leemos de nuevo
        lw   $t1, 0($t0)

        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t1, $t2, ok

        addi $a0, $zero, 88      # 'X' = falló
        j    print
ok:     addi $a0, $zero, 71      # 'G'
print:  addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall
