beq $zero, $zero, yes
j no

yes:
addi $t0, $zero, 1
j end

no:
addi $t0, $zero, 2

end:
addi $v0, $zero, 10
syscall
