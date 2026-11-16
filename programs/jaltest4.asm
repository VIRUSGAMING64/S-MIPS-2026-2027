# Diagnóstico anidamiento
# Salida esperada: XYAB
        .text
main:
        jal  nivel1
        addi $a0, $zero, 66      # 'B'
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall

nivel1:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)

        addi $a0, $zero, 88      # 'X'  ← marca que llegamos aquí
        addi $v0, $zero, 11
        syscall

        jal  nivel2

        addi $a0, $zero, 89      # 'Y'  ← marca que volvimos de nivel2
        addi $v0, $zero, 11
        syscall

        lw   $ra, 0($sp)
        addi $sp, $sp, 4

        addi $a0, $zero, 65      # 'A'
        addi $v0, $zero, 11
        syscall
        jr   $ra

nivel2:
        jr   $ra
