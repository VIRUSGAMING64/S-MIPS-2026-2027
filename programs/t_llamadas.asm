# Instrucciones: jal, jr.
# Casos de la tabla 3 que cubre:
#  - procedimiento que llama a otro (no hoja), guardando $ra en la pila y
#    retornando correctamente (f llama a g).
#  - recursion (suma(n) = n + suma(n-1)) para anidar varios niveles.
#  - jr con un registro distinto de $ra.
# Imprime los resultados en hexadecimal; al final imprime $sp.
        .text
main:

        li   $a0, 3
        jal  f                       # f(3) = g(4) + 3 = 8 + 3 = 11
        move $a0, $v1
        jal  ph
        li   $a0, 10
        jal  suma                    # suma(10) = 55
        move $a0, $v1
        jal  ph
        li   $a0, 0
        jal  suma                    # suma(0) = 0
        move $a0, $v1
        jal  ph
        li   $a0, 100
        jal  suma                    # suma(100) = 5050
        move $a0, $v1
        jal  ph
        jal  nl
        la   $ra, vuelta             # jr con registro distinto de $ra
        la   $t5, g
        li   $a0, 21
        jr   $t5                     # g(21) = 42, vuelve a "vuelta"
vuelta: move $a0, $v1
        jal  ph
        li   $a0, 7
        jal  f                       # otra llamada: $ra restaurado correctamente
        move $a0, $v1
        jal  ph
        move $a0, $sp                # la pila debe quedar como al principio
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

f:      addi $sp, $sp, -8            # procedimiento no hoja: guarda $ra y $a0
        sw   $ra, 4($sp)
        sw   $a0, 0($sp)
        addi $a0, $a0, 1
        jal  g
        lw   $a0, 0($sp)
        lw   $ra, 4($sp)
        addi $sp, $sp, 8
        add  $v1, $v1, $a0
        jr   $ra
g:      sll  $v1, $a0, 1             # procedimiento hoja: v1 = 2 * a0
        jr   $ra
suma:   addi $sp, $sp, -8            # recursivo
        sw   $ra, 4($sp)
        sw   $a0, 0($sp)
        bne  $a0, $zero, s_rec
        li   $v1, 0
        j    s_fin
s_rec:  addi $a0, $a0, -1
        jal  suma
        lw   $a0, 0($sp)
        add  $v1, $v1, $a0
s_fin:  lw   $ra, 4($sp)
        addi $sp, $sp, 8
        jr   $ra
