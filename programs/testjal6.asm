.text
    jal prin
    addi $s0,$s0, 1
    addi $v0,$zero, 10
    syscall

prin:
    jr $ra
