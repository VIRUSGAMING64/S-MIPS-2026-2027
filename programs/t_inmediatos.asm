# Instrucciones: addi, addiu y addu (via li y move), andi, ori, lui.
# Casos de la tabla 3 que cubre:
#  - addi con inmediato negativo.
#  - addiu / addu mediante las pseudoinstrucciones li (constantes entre
#    -2^15 y 2^15-1) y move.
#  - andi, ori con inmediato de bit 15 = 1 (se extiende con ceros).
#  - lui con inmediato de bit 15 = 1.
# Imprime cada resultado en hexadecimal (8 digitos + espacio).
        .text
main:
        li   $s0, 1000
        li   $s1, -7
        addi $a0, $s0, -1            # 1000 - 1 = 999
        jal  ph
        addi $a0, $s1, -32768        # -7 - 32768 (inmediato negativo minimo)
        jal  ph
        addi $a0, $s0, 100           # inmediato positivo
        jal  ph
        addi $a0, $zero, -1          # 0xffffffff
        jal  ph
        addi $a0, $s1, 32767         # -7 + 32767
        jal  ph
        jal  nl
        li   $a0, -32768             # addiu, minimo
        jal  ph
        li   $a0, 32767              # addiu, maximo
        jal  ph
        li   $a0, -1                 # addiu
        jal  ph
        li   $a0, 0                  # addiu
        jal  ph
        li   $a0, 255                # addiu
        jal  ph
        jal  nl
        move $a0, $s1                # addu con negativo
        jal  ph
        move $a0, $s0                # addu con positivo
        jal  ph
        move $a0, $zero              # addu con $zero
        jal  ph
        jal  nl
        andi $a0, $s1, 0x8000        # bit 15 = 1: extension con ceros
        jal  ph
        andi $a0, $s1, 0xff0f        # bit 15 = 1
        jal  ph
        andi $a0, $s0, 0xffff        # 1000 & 0xffff
        jal  ph
        andi $a0, $s1, 0xffff        # -7 & 0xffff
        jal  ph
        jal  nl
        ori  $a0, $zero, 0x8000      # bit 15 = 1: no 0xffff8000
        jal  ph
        ori  $a0, $s0, 0xf000        # 1000 | 0xf000
        jal  ph
        ori  $a0, $s1, 0x0f0f        # -7 | 0x0f0f
        jal  ph
        ori  $a0, $zero, 0xffff      # 0x0000ffff
        jal  ph
        jal  nl
        lui  $a0, 0x8000             # bit 15 = 1
        jal  ph
        lui  $a0, 0xffff             # bit 15 = 1
        jal  ph
        lui  $a0, 0x0001             # 0x00010000
        jal  ph
        lui  $a0, 0x1234             # 0x12340000
        jal  ph
        lui  $a0, 0x8001             # bit 15 = 1
        jal  ph
        jal  nl
        lui  $a0, 0xdead
        ori  $a0, $a0, 0xbeef        # 0xdeadbeef (lui + ori con bit 15 = 1)
        jal  ph
        li   $a0, 0x80008000         # li de 32 bits (lui + ori)
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
