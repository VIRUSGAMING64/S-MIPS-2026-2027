# testlw: lw (load word) carga una palabra de 32 bits de la memoria en un
# registro. La memoria es little-endian y la palabra debe quedar alineada.
# Instrucciones usadas (8 distintas): lw, la, addi, lui, ori, beq, bne, jal, jr, syscall
# Por que esas: lw es lo que se prueba; la da la direccion base de los datos;
# lui/ori construyen los valores esperados con los que se compara; beq/bne
# comparan; jal/jr usan un subprograma para imprimir.
# Probar antes: la, lui, ori, beq/bne, jal/jr, syscall
# Observacion: cada caso imprime su letra si el resultado es el esperado y 'X'
# si falla, de modo que se ve de un vistazo que caso se ha equivocado.
# Casos:
#   A: base $zero y desplazamiento 0 (direccion absoluta 0x2000)
#   B: base en un registro y desplazamiento 0
#   C: desplazamiento positivo (+4)
#   D: desplazamiento negativo (-4)
#   E: palabra 0xFFFFFFFF: los 32 bits se copian tal cual
#   F: palabra 0x80000000: el bit 31 se conserva
#   G: rt = $zero no escribe y no modifica la memoria
#   H: rs = rt (la base y el destino son el mismo registro)
#   I: uso inmediato del valor cargado (RAW): lw y despues addi
#   J: lw encadenado: se carga un puntero y luego el dato apuntado
# Salida esperada (1 linea):
#   ABCDEFGHIJ
        .data
d0:     .word 0x0A0B0C0D         # 0x2000
d1:     .word 0x12345678         # 0x2004
d2:     .word 0x87654321         # 0x2008
d3:     .word 0xFFFFFFFF         # 0x200C
d4:     .word 0x80000000         # 0x2010
d5:     .word 0x0000000A         # 0x2014
d6:     .word 0x00000000         # 0x2018
ptr:    .word 0x00002004         # 0x201C: direccion de d1
        .text
main:
        # caso A: base $zero, direccion absoluta
        lw   $t1, 8192($zero)
        lui  $t2, 0x0A0B
        ori  $t2, $t2, 0x0C0D
        beq  $t1, $t2, a_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    a_muestra
a_bueno:
        addi $a0, $zero, 65         # 'A'
a_muestra:
        jal  imprimir
        # caso B: base en un registro, desplazamiento 0
        la   $t0, d1
        lw   $t1, 0($t0)
        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t1, $t2, b_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    b_muestra
b_bueno:
        addi $a0, $zero, 66         # 'B'
b_muestra:
        jal  imprimir
        # caso C: desplazamiento positivo
        la   $t0, d1
        lw   $t1, 4($t0)
        lui  $t2, 0x8765
        ori  $t2, $t2, 0x4321
        beq  $t1, $t2, c_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    c_muestra
c_bueno:
        addi $a0, $zero, 67         # 'C'
c_muestra:
        jal  imprimir
        # caso D: desplazamiento negativo
        la   $t0, d1
        lw   $t1, -4($t0)
        lui  $t2, 0x0A0B
        ori  $t2, $t2, 0x0C0D
        beq  $t1, $t2, d_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    d_muestra
d_bueno:
        addi $a0, $zero, 68         # 'D'
d_muestra:
        jal  imprimir
        # caso E: palabra 0xFFFFFFFF
        la   $t0, d3
        lw   $t1, 0($t0)
        lui  $t2, 0xFFFF
        ori  $t2, $t2, 0xFFFF
        beq  $t1, $t2, e_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    e_muestra
e_bueno:
        addi $a0, $zero, 69         # 'E'
e_muestra:
        jal  imprimir
        # caso F: palabra 0x80000000 (bit 31 a 1)
        la   $t0, d4
        lw   $t1, 0($t0)
        lui  $t2, 0x8000
        beq  $t1, $t2, f_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    f_muestra
f_bueno:
        addi $a0, $zero, 70         # 'F'
f_muestra:
        jal  imprimir
        # caso G: escribir en $zero no tiene efecto y no altera la memoria
        la   $t0, d1
        lw   $zero, 0($t0)
        lw   $t1, 0($t0)
        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t1, $t2, g_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    g_muestra
g_bueno:
        addi $a0, $zero, 71         # 'G'
g_muestra:
        jal  imprimir
        # caso H: rs = rt, la base y el destino son el mismo registro
        la   $t0, d1
        lw   $t0, 0($t0)
        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t0, $t2, h_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    h_muestra
h_bueno:
        addi $a0, $zero, 72         # 'H'
h_muestra:
        jal  imprimir
        # caso I: uso inmediato del valor cargado (dependencia RAW)
        la   $t0, d1
        lw   $t1, 0($t0)
        addi $t2, $t1, 1
        lui  $t3, 0x1234
        ori  $t3, $t3, 0x5679
        beq  $t2, $t3, i_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    i_muestra
i_bueno:
        addi $a0, $zero, 73         # 'I'
i_muestra:
        jal  imprimir
        # caso J: lw encadenado: primero el puntero, luego el dato apuntado
        la   $t0, ptr
        lw   $t1, 0($t0)           # $t1 = direccion de d1
        lw   $t2, 0($t1)           # $t2 = 0x12345678
        lui  $t3, 0x1234
        ori  $t3, $t3, 0x5678
        beq  $t2, $t3, j_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    j_muestra
j_bueno:
        addi $a0, $zero, 74         # 'J'
j_muestra:
        jal  imprimir
        # fin del programa
        addi $v0, $zero, 10
        syscall

# imprime el caracter de $a0 en el TTY y vuelve
imprimir:
        addi $v0, $zero, 11
        syscall
        jr   $ra
