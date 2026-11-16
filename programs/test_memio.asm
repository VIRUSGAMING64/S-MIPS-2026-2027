.data
n: .word 1
.text
# Just read ourselves
la $t0, n
lw $v0, 0($t0)
addi $v0, $zero, 9
syscall
