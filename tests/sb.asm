# i20_sb: sb: guarda un byte en el carril (rs+imm)[1:0].
# Instrucciones usadas (4 distintas): addi, lbu, sb, syscall
# Por que esas: lbu es la forma de ver el byte guardado y sus vecinos (zero-ext).
# Probar antes: syscall (i01), addi (i02), lbu (i18)
# Observacion: el resultado se deja en $v0 (o se corrige con addi hasta valer 11) y se hace syscall:
# la letra de cada caso SOLO sale si $v0 vale exactamente 11 (32 bits). Una letra que falta senala
# el caso que falla (la lista de casos esta abajo). En MARS salen todas.
# Casos:
#   A: sb 55 en el carril 0 y leerlo con lbu
#   B: sb 66 en el carril 1 y leerlo con lbu
#   C: sb 77 en el carril 2 y leerlo con lbu
#   D: sb 88 en el carril 3 y leerlo con lbu
#   E: el carril 0 conserva 55 (los otros sb no lo pisaron)
#   F: el carril 1 conserva 66 (los otros sb no lo pisaron)
#   G: el carril 2 conserva 77 (los otros sb no lo pisaron)
#   H: el carril 3 conserva 88 (los otros sb no lo pisaron)
#   I: solo se guardan los 8 bits bajos: 267 = 0x10B guarda 0x0B
#   J: ...y el bit 8 no se cuela en el carril 1 (sigue en 66)
#   K: desplazamiento negativo: base B+4, -1 -> carril 3, guarda 99
#   L: base desalineada + desplazamiento: (B-2) + 3 = B+1, guarda 11
#   M: sb de $zero escribe 0 en el carril 2
#   N: otra palabra, carril 3: guarda 11 en B+7
# Salida esperada (1 lineas):
#   ABCDEFGHIJKLMN
        .data
        .word 740365835
        .word 0
        .word 0
        .text
# caso A: sb 55 en el carril 0 y leerlo con lbu
        addi $a0, $zero, 65
        addi $t0, $zero, 55
        sb $t0, 8192($zero)
        lbu $t1, 8192($zero)
        addi $v0, $t1, -44
        syscall
# caso B: sb 66 en el carril 1 y leerlo con lbu
        addi $a0, $zero, 66
        addi $t0, $zero, 66
        sb $t0, 8193($zero)
        lbu $t1, 8193($zero)
        addi $v0, $t1, -55
        syscall
# caso C: sb 77 en el carril 2 y leerlo con lbu
        addi $a0, $zero, 67
        addi $t0, $zero, 77
        sb $t0, 8194($zero)
        lbu $t1, 8194($zero)
        addi $v0, $t1, -66
        syscall
# caso D: sb 88 en el carril 3 y leerlo con lbu
        addi $a0, $zero, 68
        addi $t0, $zero, 88
        sb $t0, 8195($zero)
        lbu $t1, 8195($zero)
        addi $v0, $t1, -77
        syscall
# caso E: el carril 0 conserva 55 (los otros sb no lo pisaron)
        addi $a0, $zero, 69
        lbu $t1, 8192($zero)
        addi $v0, $t1, -44
        syscall
# caso F: el carril 1 conserva 66 (los otros sb no lo pisaron)
        addi $a0, $zero, 70
        lbu $t1, 8193($zero)
        addi $v0, $t1, -55
        syscall
# caso G: el carril 2 conserva 77 (los otros sb no lo pisaron)
        addi $a0, $zero, 71
        lbu $t1, 8194($zero)
        addi $v0, $t1, -66
        syscall
# caso H: el carril 3 conserva 88 (los otros sb no lo pisaron)
        addi $a0, $zero, 72
        lbu $t1, 8195($zero)
        addi $v0, $t1, -77
        syscall
# caso I: solo se guardan los 8 bits bajos: 267 = 0x10B guarda 0x0B
        addi $a0, $zero, 73
        addi $t0, $zero, 267
        sb $t0, 8192($zero)
        lbu $v0, 8192($zero)
        syscall
# caso J: ...y el bit 8 no se cuela en el carril 1 (sigue en 66)
        addi $a0, $zero, 74
        lbu $t1, 8193($zero)
        addi $v0, $t1, -55
        syscall
# caso K: desplazamiento negativo: base B+4, -1 -> carril 3, guarda 99
        addi $a0, $zero, 75
        addi $t1, $zero, 8196
        addi $t0, $zero, 99
        sb $t0, -1($t1)
        lbu $t2, 8195($zero)
        addi $v0, $t2, -88
        syscall
# caso L: base desalineada + desplazamiento: (B-2) + 3 = B+1, guarda 11
        addi $a0, $zero, 76
        addi $s7, $zero, 8190
        addi $t0, $zero, 11
        sb $t0, 3($s7)
        lbu $v0, 8193($zero)
        syscall
# caso M: sb de $zero escribe 0 en el carril 2
        addi $a0, $zero, 77
        sb $zero, 8194($zero)
        lbu $t1, 8194($zero)
        addi $v0, $t1, 11
        syscall
# caso N: otra palabra, carril 3: guarda 11 en B+7
        addi $a0, $zero, 78
        addi $t0, $zero, 11
        sb $t0, 8199($zero)
        lbu $v0, 8199($zero)
        syscall
# fin: halt y codigo muerto que NO debe ejecutarse
        addi $v0, $zero, 10
        syscall
        addi $a0, $zero, 90
        addi $v0, $zero, 11
        syscall
