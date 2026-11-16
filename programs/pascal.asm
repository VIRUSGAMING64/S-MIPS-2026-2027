# Triangulo de Pascal (8 filas) por el TTY. Cada fila se guarda en memoria y se
# actualiza en el sitio de derecha a izquierda: row[j] = row[j] + row[j-1].
# Solo usa instrucciones de la tabla 3 (sin mul/div). Salida: syscall 11.

.data
row: .space 40               # 10 palabras (la fila mas larga usa 8)

.text
main:
    la   $s0, row
    li   $t0, 1
    sw   $t0, 0($s0)         # fila 0 = [1]
    li   $s1, 0              # n = fila actual
    li   $s2, 8              # numero de filas

p_row:
    slt  $t0, $s1, $s2
    beq  $t0, $zero, p_done
    li   $s3, 0              # j
p_print:
    slt  $t0, $s1, $s3       # j > n ?
    bne  $t0, $zero, p_nl
    sll  $t1, $s3, 2
    add  $t1, $t1, $s0
    lw   $a0, 0($t1)
    jal  print_int
    li   $a0, 32             # ' '
    li   $v0, 11
    syscall
    addi $s3, $s3, 1
    j    p_print
p_nl:
    li   $a0, 10
    li   $v0, 11
    syscall
    addi $s3, $s1, 1         # actualizar: j = n+1 ... 1
p_upd:
    beq  $s3, $zero, p_next
    sll  $t1, $s3, 2
    add  $t1, $t1, $s0
    lw   $t2, 0($t1)
    lw   $t3, -4($t1)
    add  $t2, $t2, $t3
    sw   $t2, 0($t1)
    addi $s3, $s3, -1
    j    p_upd
p_next:
    addi $s1, $s1, 1
    j    p_row

p_done:
    li   $v0, 10
    syscall

# print_int: imprime $a0 en decimal (-999..999) sin ceros a la izquierda
print_int:
    slt  $t0, $a0, $zero
    beq  $t0, $zero, pi_pos
    move $t9, $a0
    li   $a0, 45             # '-'
    li   $v0, 11
    syscall
    sub  $a0, $zero, $t9
pi_pos:
    move $t1, $a0
    li   $t2, 0              # centenas
pi_h:
    slti $t3, $t1, 100
    bne  $t3, $zero, pi_hd
    addi $t1, $t1, -100
    addi $t2, $t2, 1
    j    pi_h
pi_hd:
    li   $t4, 0              # decenas
pi_t:
    slti $t3, $t1, 10
    bne  $t3, $zero, pi_td
    addi $t1, $t1, -10
    addi $t4, $t4, 1
    j    pi_t
pi_td:
    beq  $t2, $zero, pi_nh
    addi $a0, $t2, 48
    li   $v0, 11
    syscall
    j    pi_pt
pi_nh:
    beq  $t4, $zero, pi_pu
pi_pt:
    addi $a0, $t4, 48
    li   $v0, 11
    syscall
pi_pu:
    addi $a0, $t1, 48
    li   $v0, 11
    syscall
    jr   $ra
