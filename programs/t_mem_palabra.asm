# Instrucciones: lw, sw.
# Casos de la tabla 3 que cubre:
#  - lw, sw con desplazamiento positivo y con desplazamiento negativo
#    (base $gp, que se coloca en una zona libre de la memoria de datos).
# Se escribe siempre antes de leer. Imprime las palabras leidas.
        .text
main:
        addi $gp, $sp, -256          # base de pruebas: zona libre (0x3efc)
        li   $s0, 0x11111111
        li   $s1, 0x22222222
        li   $s2, 0x33333333
        li   $s3, 0x44444444
        li   $s4, 0x55555555
        sw   $s0, 0($gp)             # desplazamiento 0
        sw   $s1, 4($gp)             # positivo
        sw   $s2, 8($gp)
        sw   $s3, -4($gp)            # negativo
        sw   $s4, -8($gp)
        lw   $a0, 0($gp)             # esperado 11111111
        jal  ph
        lw   $a0, 4($gp)             # esperado 22222222
        jal  ph
        lw   $a0, 8($gp)             # esperado 33333333
        jal  ph
        lw   $a0, -4($gp)            # esperado 44444444
        jal  ph
        lw   $a0, -8($gp)            # esperado 55555555
        jal  ph
        jal  nl
        addi $s5, $gp, 16            # otra base: desplazamientos con signo desde $gp+16
        lw   $a0, -12($s5)           # = gp+4: 22222222
        jal  ph
        lw   $a0, -16($s5)           # = gp+0: 11111111
        jal  ph
        lw   $a0, -24($s5)           # = gp-8: 55555555
        jal  ph
        jal  nl
        li   $s6, 0xa5a5a5a5
        li   $s7, 0x5a5a5a5a
        sw   $s6, 100($gp)
        sw   $s7, -100($gp)
        lw   $a0, 100($gp)           # a5a5a5a5
        jal  ph
        lw   $a0, -100($gp)          # 5a5a5a5a
        jal  ph
        lw   $a0, 0($gp)             # sin cambios: 11111111
        jal  ph
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
