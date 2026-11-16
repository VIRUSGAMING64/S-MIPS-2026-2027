# Test jal mínimo: solo un jal y vuelta
# Debe imprimir: A
        .text
main:
        jal  func
        addi $a0, $zero, 65      # 'A'
        addi $v0, $zero, 11
        syscall
        addi $v0, $zero, 10
        syscall

func:
        jr   $ra
