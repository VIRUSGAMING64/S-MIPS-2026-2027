.text
test:
    addi $a0, $zero, 42 
    j fin
init:
    j main
print:
    addi $a0, $zero, 42
    addi $v0, $zero, 11
    syscall
    j fin

main:
    addi $s0, $zero, -1
    addi $s1, $zero, -1
    beq $s0, $s1, print
fin:
    addi $v0, $zero, 10
    syscall
