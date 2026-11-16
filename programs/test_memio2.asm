.data
abcd:
.asciiz "abcd"
.text
main:
la $t0, abcd
lbu $t1, 0($t0)
addi $t1, $t1, 1
sb $t1, 0($gp)

lbu $a0, 0($gp)
addi $v0, $zero, 11
syscall

addi $a0, $zero, 10
syscall
