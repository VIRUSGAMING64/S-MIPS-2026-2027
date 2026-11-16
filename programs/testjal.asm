.text
start:
	addi $a0, $zero, 65
	j main
	
perr:
	addi $a0, $a0, 1
	j cont
	
imprimir:
	addi $v0, $zero, 11
	syscall
	jr $ra
	
main:
	jal imprimir
	j perr
cont:
	jal imprimir
	addi $v0, $zero, 10
	syscall
	