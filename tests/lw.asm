# i16_lw: lw: carga una palabra de 32 bits (little-endian).
# Instrucciones usadas (3 distintas): addi, lw, syscall
# Por que esas: los datos estan en .data; addi corrige resultados.
# Probar antes: syscall (i01), addi (i02)
# Observacion: el resultado se deja en $v0 (o se corrige con addi hasta valer 11) y se hace syscall:
# la letra de cada caso SOLO sale si $v0 vale exactamente 11 (32 bits). Una letra que falta senala
# el caso que falla (la lista de casos esta abajo). En MARS salen todas.
# Casos:
#   A: palabra 11
#   B: palabra -1: cargan los 4 bytes
#   C: palabra 0x00010000 (byte 2)
#   D: palabra 0x00000100 (byte 1)
#   E: palabra 0xFFFF0000 (bytes 2 y 3)
#   F: rt = $a0, el dato es el caracter
#   G: desplazamiento negativo con base en registro
#   H: base desalineada cuya suma queda alineada (base + 2, desplazamiento 2)
#   I: lw a $zero no escribe
#   J: uso inmediato tras la carga (RAW): -11 + 22
#   K: rs = rt (base y destino son el mismo registro)
# Salida esperada (1 lineas):
#   ABCDEFGHIJK
        .data
        .word 11
        .word -1
        .word 65536
        .word 256
        .word -65536
        .word -11
        .word 70
        .text
# caso A: palabra 11
        addi $a0, $zero, 65
        lw $v0, 8192($zero)
        syscall
# caso B: palabra -1: cargan los 4 bytes
        addi $a0, $zero, 66
        lw $t0, 8196($zero)
        addi $v0, $t0, 12
        syscall
# caso C: palabra 0x00010000 (byte 2)
        addi $a0, $zero, 67
        lw $t0, 8200($zero)
        addi $v0, $t0, -32768
        addi $v0, $v0, -32757
        syscall
# caso D: palabra 0x00000100 (byte 1)
        addi $a0, $zero, 68
        lw $t0, 8204($zero)
        addi $v0, $t0, -245
        syscall
# caso E: palabra 0xFFFF0000 (bytes 2 y 3)
        addi $a0, $zero, 69
        lw $t0, 8208($zero)
        addi $v0, $t0, 32767
        addi $v0, $v0, 32767
        addi $v0, $v0, 13
        syscall
# caso F: rt = $a0, el dato es el caracter
        addi $v0, $zero, 11
        lw $a0, 8216($zero)
        syscall
# caso G: desplazamiento negativo con base en registro
        addi $a0, $zero, 71
        addi $t1, $zero, 8200
        lw $v0, -8($t1)
        syscall
# caso H: base desalineada cuya suma queda alineada (base + 2, desplazamiento 2)
        addi $a0, $zero, 72
        addi $s7, $zero, 8190
        lw $v0, 2($s7)
        syscall
# caso I: lw a $zero no escribe
        addi $a0, $zero, 73
        lw $zero, 8196($zero)
        addi $v0, $zero, 11
        syscall
# caso J: uso inmediato tras la carga (RAW): -11 + 22
        addi $a0, $zero, 74
        lw $t2, 8212($zero)
        addi $v0, $t2, 22
        syscall
# caso K: rs = rt (base y destino son el mismo registro)
        addi $a0, $zero, 75
        addi $t3, $zero, 8192
        lw $t3, 0($t3)
        addi $v0, $t3, 0
        syscall
# fin: halt y codigo muerto que NO debe ejecutarse
        addi $v0, $zero, 10
        syscall
        addi $a0, $zero, 90
        addi $v0, $zero, 11
        syscall
