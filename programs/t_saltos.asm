# Instrucciones: beq, bne, j.
# Casos de la tabla 3 que cubre:
#  - beq y bne, cada uno tomado y no tomado (con iguales positivos, iguales
#    negativos y valores que solo difieren en los 16 bits altos).
#  - al menos un salto hacia atras (bucle con bne y bucle con beq).
#  - j al menos una vez.
# Cada caso imprime 1 si el salto se toma y 2 si no se toma.
        .text
main:
        li   $s0, 5
        li   $s1, 5
        li   $s2, 7
        li   $s3, -3
        li   $s4, -3
        li   $s5, 0x00010005
        li   $s6, 0x00020005
        li   $a0, 1
        beq  $s0, $s1, c1            # iguales: se toma -> 1
        li   $a0, 2
c1:     jal  ph
        li   $a0, 1
        beq  $s0, $s2, c2            # distintos: no se toma -> 2
        li   $a0, 2
c2:     jal  ph
        li   $a0, 1
        beq  $s3, $s4, c3            # iguales negativos: se toma -> 1
        li   $a0, 2
c3:     jal  ph
        li   $a0, 1
        beq  $s5, $s6, c4            # difieren en los bits altos: no se toma -> 2
        li   $a0, 2
c4:     jal  ph
        jal  nl
        li   $a0, 1
        bne  $s0, $s2, c5            # distintos: se toma -> 1
        li   $a0, 2
c5:     jal  ph
        li   $a0, 1
        bne  $s0, $s1, c6            # iguales: no se toma -> 2
        li   $a0, 2
c6:     jal  ph
        li   $a0, 1
        bne  $s3, $s4, c7            # iguales negativos: no se toma -> 2
        li   $a0, 2
c7:     jal  ph
        li   $a0, 1
        bne  $s5, $s6, c8            # difieren en los bits altos: se toma -> 1
        li   $a0, 2
c8:     jal  ph
        jal  nl
        li   $t4, 5                  # bucle con bne hacia atras: 5 * 3 = 15
        li   $a0, 0
lp1:    addi $a0, $a0, 3
        addi $t4, $t4, -1
        bne  $t4, $zero, lp1         # salto hacia atras
        jal  ph
        li   $t4, 0                  # bucle con beq hacia atras: cuenta hasta 3
lp2:    addi $t4, $t4, 1
        li   $t5, 3
        beq  $t4, $t5, lp2o          # salida hacia delante
        beq  $zero, $zero, lp2       # beq hacia atras, siempre tomado
lp2o:   move $a0, $t4
        jal  ph
        jal  nl
        li   $a0, 0x1111
        j    jd1                     # salta sobre la instruccion siguiente
        li   $a0, 0x0bad
jd1:    jal  ph
        li   $a0, 0x2222
        j    jd2                     # salta sobre varias instrucciones
        li   $a0, 0x0bad
        addi $a0, $a0, 1
        addi $a0, $a0, 1
jd2:    jal  ph
        jal  nl
        li   $v0, 10                 # terminar
        syscall

# ---- rutinas auxiliares ----
ph:     move $t0, $a0                # imprime $a0 en hexadecimal + espacio
        li   $t1, 8
ph_b:   srl  $t2, $t0, 28
        slti $t3, $t2, 10
        beq  $t3, $zero, ph_l
        addi $a0, $t2, 48
        j    ph_p
ph_l:   addi $a0, $t2, 87
ph_p:   li   $v0, 11
        syscall
        sll  $t0, $t0, 4
        addi $t1, $t1, -1
        bne  $t1, $zero, ph_b
        li   $a0, 32
        li   $v0, 11
        syscall
        jr   $ra
nl:     li   $a0, 10                 # salto de linea
        li   $v0, 11
        syscall
        jr   $ra
