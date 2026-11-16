nop
nop
nop
# V0 <- 0
add $v0, $zero, $zero

# V0 <- V0 | ZeroExt(-1) = V0 | 0xFFFF
ori $v0, $zero, 0xffff

# V0 <- V0 + 1
# (may be 0 if sign extended)
addi $v0, $v0, 1

# if V0==0 goto loop
beq $v0, $zero, loop

# Halt
addi $v0, $zero, 10
syscall

loop:
j loop