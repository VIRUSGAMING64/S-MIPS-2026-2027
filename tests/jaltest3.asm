# Test: jal + jr + otra instrucción
# Debe imprimir: AB
        .text
main:
        jal  func
        addi $a0, $zero, 66      # 'B'
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall

func:
        addi $a0, $zero, 65      # 'A'
        addi $v0, $zero, 11
        syscall
        jr   $ra
