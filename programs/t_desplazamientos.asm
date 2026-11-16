# Instrucciones: sll, srl.
# Casos de la tabla 3 que cubre:
#  - sll y srl con shamt = 0 y con shamt != 0.
#  - srl sobre valores negativos (deben entrar ceros).
# Imprime cada resultado en hexadecimal (8 digitos + espacio).
        .text
main:
        li   $s0, 0x12345678
        li   $s1, 0x80000001
        li   $s2, -1
        sll  $a0, $s0, 0             # shamt = 0
        jal  ph
        sll  $a0, $s0, 4             # shamt = 4
        jal  ph
        sll  $a0, $s0, 8             # shamt = 8
        jal  ph
        sll  $a0, $s0, 31            # shamt = 31
        jal  ph
        jal  nl
        srl  $a0, $s0, 0             # shamt = 0
        jal  ph
        srl  $a0, $s0, 4             # shamt = 4
        jal  ph
        srl  $a0, $s0, 16            # shamt = 16
        jal  ph
        srl  $a0, $s0, 31            # shamt = 31
        jal  ph
        jal  nl
        srl  $a0, $s1, 0             # negativo, shamt = 0
        jal  ph
        srl  $a0, $s1, 1             # negativo: entran ceros
        jal  ph
        srl  $a0, $s1, 4             # negativo: entran ceros
        jal  ph
        srl  $a0, $s1, 31            # negativo -> 1
        jal  ph
        jal  nl
        sll  $a0, $s1, 1             # negativo a la izquierda
        jal  ph
        sll  $a0, $s1, 0             # negativo, shamt = 0
        jal  ph
        jal  nl
        srl  $a0, $s2, 28            # -1 >> 28
        jal  ph
        srl  $a0, $s2, 1             # -1 >> 1
        jal  ph
        sll  $a0, $s2, 16            # -1 << 16
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
