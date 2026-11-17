.data
s: .asciiz "abacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacabaabacaacaba"
size: .word 1000 
.text

main:
    la $a1, s
    la $t0, size
    lw $s1, 0($t0)
    lw $t0, 0($t0)
    addi $a2, $a1, -1
    add $a3, $a1, $t0

loop:
    addi $a2, $a2, 1
    addi $a3, $a3, -1
    addi $s1, $s1, -1
    beq $s1, $zero, loopend

    lbu $t1, 0($a2)
    lbu $t2, 0($a3)
    
    bne $t1, $t2, noeq
    j loop

loopend:
    jal yes
    j end

showchar:
    addi $v0, $zero, 11
    syscall
    jr $ra

yes:
    li $a0, 49
    li $v0, 11
    syscall
    jr $ra

no:
    li $a0, 48
    li $v0, 11
    syscall
    jr $ra

noeq:
    jal no
    j end

end:
    addi $v0, $zero, 10
    syscall

