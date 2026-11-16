# Test lw con desplazamiento negativo
# Salida esperada: AB
        .data
a:      .word 0x11111111
b:      .word 0x22222222
c:      .word 0x33333333

        .text
main:
        la   $s0, b              # s0 apunta a b

        # Caso A: lw con offset 0
        lw   $t0, 0($s0)
        lui  $t1, 0x2222
        ori  $t1, $t1, 0x2222
        beq  $t0, $t1, a_ok
        addi $a0, $zero, 88      # 'X'
        j    a_print
a_ok:   addi $a0, $zero, 65      # 'A'
a_print:
        addi $v0, $zero, 11
        syscall

        # Caso B: lw con offset -4 (debe leer a)
        lw   $t0, -4($s0)
        lui  $t1, 0x1111
        ori  $t1, $t1, 0x1111
        beq  $t0, $t1, b_ok
        addi $a0, $zero, 88      # 'X'
        j    b_print
b_ok:   addi $a0, $zero, 66      # 'B'
b_print:
        addi $v0, $zero, 11
        syscall

        addi $v0, $zero, 10
        syscall
