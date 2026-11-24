# Test recursión simple de 2 niveles
# Debe imprimir: AB
        .text
main:
        jal  nivel1
        addi $a0, $zero, 66      # 'B'  ← solo se ejecuta si volvió bien
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall

nivel1:
        addi $sp, $sp, -4
        sw   $ra, 0($sp)
        jal  nivel2
        lw   $ra, 0($sp)
        addi $sp, $sp, 4
        addi $a0, $zero, 65      # 'A'
        addi $v0, $zero, 11
        syscall
        jr   $ra

nivel2:
        jr   $ra                 # vuelve sin hacer nada
