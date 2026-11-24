.text
main:
        addi $a0, $zero, 65     # 'A'
        jal  f
        addi $a0, $zero, 66     # 'B'  ← solo se ejecuta si $ra fue correcto
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall

f:      addi $v0, $zero, 11
        syscall
        jr   $ra
