# test_sw_sb: test conjunto para sw (store word) y sb (store byte).
# Instrucciones usadas: addi, sw, sb, lw, lbu, syscall
# Casos:
#   A: sw palabra positiva (123) en 8192 y leer con lw
#   B: sw palabra negativa (-1) en 8196 y leer con lw
#   C: sw con desplazamiento negativo (-4 desde 8204 -> 8200) y leer con lw
#   D: sw con base en registro y offset positivo (8 desde 8192 -> 8200) y leer con lw
#   E: sb guarda 85 en carril 0 (8204) y leer con lbu
#   F: sb guarda 170 en carril 3 (8207) y leer con lbu
#   G: sb con desplazamiento negativo (-1 desde 8209 -> 8208) y leer con lbu
#   H: sw de $zero escribe 0 en 8212 y leer con lw
# Salida esperada (1 linea):
#   ABCDEFGH

        .data
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0

        .text
# caso A: sw palabra positiva (123) en 8192 y leer con lw
        addi $a0, $zero, 65
        addi $t0, $zero, 123
        sw $t0, 8192($zero)
        lw $t1, 8192($zero)
        addi $v0, $t1, -112
        syscall

# caso B: sw palabra negativa (-1) en 8196 y leer con lw
        addi $a0, $zero, 66
        addi $t0, $zero, -1
        sw $t0, 8196($zero)
        lw $t1, 8196($zero)
        addi $v0, $t1, 12
        syscall

# caso C: sw con desplazamiento negativo (-4 desde 8204 -> 8200) y leer con lw
        addi $a0, $zero, 67
        addi $t1, $zero, 8204
        addi $t0, $zero, 456
        sw $t0, -4($t1)
        lw $t2, 8200($zero)
        addi $v0, $t2, -445
        syscall

# caso D: sw con base en registro y offset positivo (8 desde 8192 -> 8200) y leer con lw
        addi $a0, $zero, 68
        addi $t1, $zero, 8192
        addi $t0, $zero, 789
        sw $t0, 8($t1)
        lw $t2, 8200($zero)
        addi $v0, $t2, -778
        syscall

# caso E: sb guarda 85 en carril 0 (8204) y leer con lbu
        addi $a0, $zero, 69
        addi $t0, $zero, 85
        sb $t0, 8204($zero)
        lbu $t1, 8204($zero)
        addi $v0, $t1, -74
        syscall

# caso F: sb guarda 170 en carril 3 (8207) y leer con lbu
        addi $a0, $zero, 70
        addi $t0, $zero, 170
        sb $t0, 8207($zero)
        lbu $t1, 8207($zero)
        addi $v0, $t1, -159
        syscall

# caso G: sb con desplazamiento negativo (-1 desde 8209 -> 8208) y leer con lbu
        addi $a0, $zero, 71
        addi $t1, $zero, 8209
        addi $t0, $zero, 99
        sb $t0, -1($t1)
        lbu $t2, 8208($zero)
        addi $v0, $t2, -88
        syscall

# caso H: sw de $zero escribe 0 en 8212 y leer con lw
        addi $a0, $zero, 72
        sw $zero, 8212($zero)
        lw $t1, 8212($zero)
        addi $v0, $t1, 11
        syscall

# fin: halt
        addi $v0, $zero, 10
        syscall
