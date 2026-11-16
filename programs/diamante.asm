# Diamante hueco por el TTY para la CPU S-MIPS.
# Solo usa: sll, add, sub, addi, slt, beq, bne, j, syscall y los pseudos li, move.
# Salida con syscall 11 (imprimir caracter); termina con syscall 10.
# Cambia N para hacerlo mas grande o mas pequeno.

.text
main:
    li   $s0, 5              # N: altura de cada mitad (filas totales = 2N-1)
    sll  $s1, $s0, 1
    addi $s1, $s1, -1        # $s1 = total de filas
    li   $t0, 0              # i = fila actual

row:
    slt  $t9, $t0, $s1
    beq  $t9, $zero, fin     # si i >= filas, terminar
    slt  $t9, $t0, $s0
    move $t1, $t0            # d = i (mitad superior)
    bne  $t9, $zero, got_d
    sub  $t1, $s1, $t0       # mitad inferior: d = filas-1-i
    addi $t1, $t1, -1
got_d:
    sub  $t2, $s0, $t1
    addi $t2, $t2, -1        # espacios = N-1-d

sp_loop:
    beq  $t2, $zero, stars
    li   $a0, 32             # ' '
    li   $v0, 11
    syscall
    addi $t2, $t2, -1
    j    sp_loop

stars:
    sll  $t4, $t1, 1         # ultimo indice = 2d
    li   $t3, 0              # j = 0
st_loop:
    slt  $t9, $t4, $t3
    bne  $t9, $zero, newline # si j > 2d, fin de fila
    li   $a0, 42             # '*' en los bordes
    beq  $t3, $zero, put
    beq  $t3, $t4, put
    li   $a0, 46             # '.' en el interior
put:
    li   $v0, 11
    syscall
    addi $t3, $t3, 1
    j    st_loop

newline:
    li   $a0, 10
    li   $v0, 11
    syscall
    addi $t0, $t0, 1
    j    row

fin:
    li   $v0, 10
    syscall
