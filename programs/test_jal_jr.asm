jal fun
addi $v1, $v0, 1
addiu $v0, $zero, 10
syscall
fun:
addi $v0, $zero, 10
jr $ra
