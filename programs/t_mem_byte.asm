# Instrucciones: lb, lbu, sb.
# Casos de la tabla 3 que cubre:
#  - lb, lbu sobre bytes con bit 7 = 1 en varias posiciones d[1:0] de la palabra
#    (posiciones 2 y 3 de la primera palabra, 2 y 3 de la segunda).
#  - sb en las cuatro posiciones de una misma palabra, comprobando despues
#    con lw que los otros bytes no cambiaron.
# Imprime los valores leidos en hexadecimal.
        .text
main:
        addi $gp, $sp, -256          # base de pruebas: zona libre (0x3efc)
        li   $s0, 0x80ff7f01
        li   $s1, 0x9a8b7c6d
        sw   $s0, 0($gp)
        sw   $s1, 4($gp)
        lb   $a0, 0($gp)             # 0x01
        jal  ph
        lb   $a0, 1($gp)             # 0x7f
        jal  ph
        lb   $a0, 2($gp)             # 0xff -> extension de signo
        jal  ph
        lb   $a0, 3($gp)             # 0x80 -> extension de signo
        jal  ph
        jal  nl
        lbu  $a0, 0($gp)             # 0x01
        jal  ph
        lbu  $a0, 1($gp)             # 0x7f
        jal  ph
        lbu  $a0, 2($gp)             # 0xff -> sin extension
        jal  ph
        lbu  $a0, 3($gp)             # 0x80 -> sin extension
        jal  ph
        jal  nl
        lb   $a0, 4($gp)             # 0x6d
        jal  ph
        lb   $a0, 5($gp)             # 0x7c
        jal  ph
        lb   $a0, 6($gp)             # 0x8b -> signo
        jal  ph
        lb   $a0, 7($gp)             # 0x9a -> signo
        jal  ph
        jal  nl
        lbu  $a0, 6($gp)             # 0x8b
        jal  ph
        lbu  $a0, 7($gp)             # 0x9a
        jal  ph
        jal  nl
        li   $s2, 0xa1b2c3d4
        li   $s3, 0x123456e7         # sb solo guarda el byte [7:0] = 0xe7
        sw   $s2, 8($gp)
        sb   $s3, 8($gp)             # posicion 0
        lw   $a0, 8($gp)             # a1b2c3e7
        jal  ph
        sw   $s2, 8($gp)
        sb   $s3, 9($gp)             # posicion 1
        lw   $a0, 8($gp)             # a1b2e7d4
        jal  ph
        sw   $s2, 8($gp)
        sb   $s3, 10($gp)            # posicion 2
        lw   $a0, 8($gp)             # a1e7c3d4
        jal  ph
        sw   $s2, 8($gp)
        sb   $s3, 11($gp)            # posicion 3
        lw   $a0, 8($gp)             # e7b2c3d4
        jal  ph
        jal  nl
        sw   $zero, 12($gp)
        li   $s4, 0x11
        li   $s5, 0x22
        li   $s6, 0x33
        li   $s7, 0x44
        sb   $s4, 12($gp)
        sb   $s5, 13($gp)
        sb   $s6, 14($gp)
        sb   $s7, 15($gp)
        lw   $a0, 12($gp)            # 44332211 (cuatro sb seguidos)
        jal  ph
        lb   $a0, 13($gp)            # 0x22
        jal  ph
        sb   $s3, 13($gp)            # 0xe7 en la posicion 1
        lb   $a0, 13($gp)            # ffffffe7
        jal  ph
        lbu  $a0, 13($gp)            # 000000e7
        jal  ph
        lw   $a0, 12($gp)            # 4433e711
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
