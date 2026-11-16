.data
A: .asciiz "ABCD"
.text
la $t0, A
lw $t1, 0($t0)
sw $t1, 0($t0)
lw $t2, 0($t0)
sub $t1, $t1, $t2
bne $t1, $zero, loop
addi $v0, $zero, 10
syscall # halt
loop:
j loop
