# Instrucciones: syscall (servicios 11 y 10) y escritura en $zero.
# Casos de la tabla 3 que cubre:
#  - syscall: servicio 11 (imprimir caracter) y servicio 10 (terminar).
#  - $zero: instrucciones de distintos tipos que escriben en $zero; despues
#    se comprueba que sigue valiendo 0 (y que leerlo en otra instruccion da 0).
# Imprime en hexadecimal el valor de $zero tras cada escritura.
        .text
main:
        addi $gp, $sp, -256          # base de pruebas: zona libre (0x3efc)
        li   $s0, 7
        li   $s1, 0x1234
        sw   $s0, 0($gp)
        add  $zero, $s0, $s0
        move $a0, $zero              # add -> 0
        jal  ph
        addi $zero, $zero, 5
        move $a0, $zero              # addi -> 0
        jal  ph
        lui  $zero, 0x8001
        move $a0, $zero              # lui -> 0
        jal  ph
        ori  $zero, $zero, 0xffff
        move $a0, $zero              # ori -> 0
        jal  ph
        jal  nl
        sll  $zero, $s0, 3
        move $a0, $zero              # sll -> 0
        jal  ph
        lw   $zero, 0($gp)
        move $a0, $zero              # lw -> 0
        jal  ph
        lb   $zero, 0($gp)
        move $a0, $zero              # lb -> 0
        jal  ph
        slt  $zero, $zero, $s0
        move $a0, $zero              # slt (0<7=1) -> 0
        jal  ph
        move $zero, $s0
        move $a0, $zero              # addu -> 0
        jal  ph
        jal  nl
        add  $a0, $zero, $s0         # $zero como operando: 0 + 7 = 7
        jal  ph
        sub  $a0, $zero, $s0         # 0 - 7 = fffffff9
        jal  ph
        or   $a0, $zero, $s1         # 0 | 0x1234
        jal  ph
        li   $v0, 11                 # servicio 11 directo: imprime "Hi"
        li   $a0, 72
        syscall
        li   $a0, 105
        syscall
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
