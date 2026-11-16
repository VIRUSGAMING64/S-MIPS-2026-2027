# Instrucciones: add, sub, and, or, slt, slti.
# Casos de la tabla 3 que cubre:
#  - add, sub: operandos positivos y con al menos un operando negativo.
#  - and, or: operandos con unos en los 16 bits altos.
#  - slt, slti: resultado 1 y resultado 0; con operando negativo en que la
#    comparacion con signo y sin signo dan resultados distintos.
# Imprime cada resultado en hexadecimal (8 digitos + espacio).
        .text
main:
        li   $s0, 1000
        li   $s1, -7
        li   $s2, -3
        li   $s3, 20
        li   $s4, 22
        li   $s5, 0xffff1234
        li   $s6, 0x8000ff0f
        li   $s7, -1
        li   $v1, 1
        add  $a0, $s0, $s1           # 1000 + (-7) = 993
        jal  ph
        add  $a0, $s1, $s2           # -7 + -3 = -10
        jal  ph
        add  $a0, $s3, $s4           # 20 + 22 = 42
        jal  ph
        jal  nl
        sub  $a0, $s0, $s1           # 1000 - (-7) = 1007
        jal  ph
        sub  $a0, $s1, $s0           # -7 - 1000 = -1007
        jal  ph
        sub  $a0, $s3, $s4           # 20 - 22 = -2
        jal  ph
        sub  $a0, $s1, $s2           # -7 - (-3) = -4
        jal  ph
        jal  nl
        and  $a0, $s5, $s6           # 0xffff1234 & 0x8000ff0f
        jal  ph
        or   $a0, $s5, $s6           # 0xffff1234 | 0x8000ff0f
        jal  ph
        and  $a0, $s5, $s1           # 0xffff1234 & 0xfffffff9
        jal  ph
        jal  nl
        slt  $a0, $s1, $s0           # -7 < 1000 -> 1
        jal  ph
        slt  $a0, $s0, $s1           # 1000 < -7 -> 0
        jal  ph
        slt  $a0, $s7, $v1           # -1 < 1 -> 1 (sin signo daria 0)
        jal  ph
        slt  $a0, $v1, $s7           # 1 < -1 -> 0 (sin signo daria 1)
        jal  ph
        slt  $a0, $s3, $s3           # 20 < 20 -> 0
        jal  ph
        jal  nl
        slti $a0, $s1, -6            # -7 < -6 -> 1
        jal  ph
        slti $a0, $s0, -1            # 1000 < -1 -> 0 (sin signo daria 1)
        jal  ph
        slti $a0, $s7, 1             # -1 < 1 -> 1 (sin signo daria 0)
        jal  ph
        slti $a0, $s0, 2000          # 1000 < 2000 -> 1
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
