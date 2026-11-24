# Test beq: branch taken if equal
	addi $s0, $zero, 5
	addi $s1, $zero, 5
    beq  $s0, $s1, tomado
	addi $a0, $zero, 0       # no salto: imprime 'N'
	j  fin
tomado: 
    addi $a0, $zero, 65  # 'A'
fin:    
    addi $v0, $zero, 11
	syscall
    addi $v0, $v0, -1
    syscall
