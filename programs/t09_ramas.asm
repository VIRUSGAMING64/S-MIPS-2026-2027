# t09: beq y bne (tomado / no tomado, hacia delante y hacia atras).
# Cubre (tabla 3): beq y bne tomados y no tomados; salto hacia atras (bucle).
# No usa print_hex: cada rama imprime una letra.
# Salida esperada:  ABCDFG***E
#   A  beq tomado (5==5) salta la 'X'
#   B  beq NO tomado (5!=6)
#   C  bne tomado (5!=6) salta la 'X'
#   D  bne NO tomado (5==5)
#   F  beq $s4,$zero con s4=0x80000000: NO tomado (difieren solo en el bit 31)
#   G  bne $s4,$s5 con ambos 0x80000000: NO tomado
#   ***  bucle de 3 vueltas con bne hacia atras
#   E  fin del bucle
        addi $v0, $zero, 11
        addi $s0, $zero, 5
        addi $s1, $zero, 5
        addi $s2, $zero, 6
        beq  $s0, $s1, l1
        addi $a0, $zero, 88      # 'X'
        syscall
l1:     addi $a0, $zero, 65      # 'A'
        syscall
        beq  $s0, $s2, l2
        addi $a0, $zero, 66      # 'B'
        syscall
l2:     bne  $s0, $s2, l3
        addi $a0, $zero, 88      # 'X'
        syscall
l3:     addi $a0, $zero, 67      # 'C'
        syscall
        bne  $s0, $s1, l4
        addi $a0, $zero, 68      # 'D'
        syscall
l4:     lui  $s4, 0x8000
        beq  $s4, $zero, l5
        addi $a0, $zero, 70      # 'F'
        syscall
l5:     lui  $s5, 0x8000
        bne  $s4, $s5, l6
        addi $a0, $zero, 71      # 'G'
        syscall
l6:     addi $s3, $zero, 3
loop:   addi $a0, $zero, 42      # '*'
        syscall
        addi $s3, $s3, -1
        bne  $s3, $zero, loop    # hacia atras
        addi $a0, $zero, 69      # 'E'
        syscall
        addi $v0, $zero, 10
        syscall
