# test_jal_backward.asm
# Salida esperada: A1A2A3OK
# Si imprime otra cosa (A1A30K, A1A2A2OK, bucle infinito, etc.) 
# el problema está en el bne hacia atrás + jal
.text   
main:
        addi $s0, $zero, 0
loop:
        addi $a0, $zero, 65         # 'A'
        jal  print

        addi $a0, $s0, 49           # '1', '2', '3'
        jal  print

        addi $s0, $s0, 1
        slti $t0, $s0, 3
        bne  $t0, $zero, loop       # ← salto hacia ATRÁS

        addi $a0, $zero, 79         # 'O'
        jal  print
        addi $a0, $zero, 75         # 'K'
        jal  print

        addi $v0, $zero, 10
        syscall

print:
        addi $v0, $zero, 11
        syscall
        jr   $ra
