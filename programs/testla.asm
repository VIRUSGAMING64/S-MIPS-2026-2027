# testla: la pseudoinstruccion 'la' carga en un registro la direccion de una
# etiqueta de .text o de .data.
# Instrucciones usadas (8 distintas): la, lw, lbu, addi, sub, beq, bne, jal, jr, syscall
# Por que esas: 'la' es lo que se prueba; lw/lbu comprueban que la direccion
# cargada sirve para llegar al dato; sub/beq/bne comparan direcciones y valores;
# jal/jr usan un subprograma para imprimir.
# Probar antes: lw (i16_lw), lbu (i17_lb), beq/bne, jal/jr, syscall
# Observacion: cada caso imprime su letra si el resultado es el esperado y 'X'
# si falla, de modo que se ve de un vistazo que caso se ha equivocado.
# Casos:
#   A: la de una palabra de .data y lw: el valor leido es 0x12345678
#   B: la de un byte de .data y lbu: el byte leido es 98 ('b')
#   C: la de una cadena de .data: se imprime "OK" con lbu
#   D: la de una rutina de .text y jr: se entra en la rutina y se vuelve
#   E: la de la misma etiqueta dos veces: las dos direcciones coinciden
#   F: la de dos palabras contiguas: la diferencia de direcciones es 4
#   G: la de una palabra y lw con desplazamiento positivo y con desplazamiento
#      negativo: se leen las dos palabras contiguas
# Salida esperada (1 linea):
#   ABOKCDEFG
        .data
byte_b:  .byte 98                 # 'b'
palabra: .word 0x12345678
palabra2:.word 0x0A0B0C0D
cadena:  .asciiz "OK"
        .text
main:
        # caso A: la direccion de una palabra y lw sobre ella
        la   $t0, palabra
        lw   $t1, 0($t0)
        lui  $t2, 0x1234
        ori  $t2, $t2, 0x5678
        beq  $t1, $t2, a_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    a_muestra
a_bueno:
        addi $a0, $zero, 65         # 'A'
a_muestra:
        jal  imprimir
        # caso B: la direccion de un byte y lbu sobre ella
        la   $t0, byte_b
        lbu  $t1, 0($t0)
        addi $t2, $zero, 98
        beq  $t1, $t2, b_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    b_muestra
b_bueno:
        addi $a0, $zero, 66         # 'B'
b_muestra:
        jal  imprimir
        # caso C: la direccion de una cadena y recorrido con lbu
        la   $s0, cadena
c_bucle:
        lbu  $a0, 0($s0)
        beq  $a0, $zero, c_fin
        jal  imprimir
        addi $s0, $s0, 1
        j    c_bucle
c_fin:
        addi $a0, $zero, 67         # 'C'
        jal  imprimir
        # caso D: la direccion de una rutina de .text y jr hacia ella
        la   $t0, rutina
        la   $t1, d_sigue
        jr   $t0
d_sigue:
        # caso E: la misma etiqueta dos veces, direcciones iguales
        la   $t0, palabra
        la   $t1, palabra
        beq  $t0, $t1, e_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    e_muestra
e_bueno:
        addi $a0, $zero, 69         # 'E'
e_muestra:
        jal  imprimir
        # caso F: dos palabras contiguas, la diferencia es 4
        la   $t0, palabra
        la   $t1, palabra2
        sub  $t2, $t1, $t0
        addi $t3, $zero, 4
        beq  $t2, $t3, f_bueno
        addi $a0, $zero, 88         # 'X': fallo
        j    f_muestra
f_bueno:
        addi $a0, $zero, 70         # 'F'
f_muestra:
        jal  imprimir
        # caso G: lw con desplazamiento positivo y con desplazamiento negativo
        la   $t0, palabra2
        lw   $t1, 0($t0)           # palabra2 = 0x0A0B0C0D
        lw   $t2, -4($t0)          # palabra  = 0x12345678
        lui  $t3, 0x0A0B
        ori  $t3, $t3, 0x0C0D
        bne  $t1, $t3, g_mal
        lui  $t3, 0x1234
        ori  $t3, $t3, 0x5678
        bne  $t2, $t3, g_mal
        addi $a0, $zero, 71         # 'G'
        j    g_muestra
g_mal:
        addi $a0, $zero, 88         # 'X': fallo
g_muestra:
        jal  imprimir
        # fin del programa
        addi $v0, $zero, 10
        syscall

# rutina de .text a la que se salta con jr en el caso D
rutina:
        addi $a0, $zero, 68         # 'D'
        addi $v0, $zero, 11
        syscall
        jr   $t1

# imprime el caracter de $a0 en el TTY y vuelve
imprimir:
        addi $v0, $zero, 11
        syscall
        jr   $ra
