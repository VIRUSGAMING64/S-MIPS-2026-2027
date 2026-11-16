loop:
addi $t0, $t0, 1
addi $t1, $t0, -20
beq $t1, $zero, end
j loop
end:
addiu $v0, $zero, 10
syscall
