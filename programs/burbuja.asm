# Ordenamiento burbuja de 10 enteros (con negativos) por el TTY.
# Imprime el arreglo antes y despues de ordenar, de menor a mayor.
# Solo usa instrucciones de la tabla 3. Salida: syscall 11.

.data
arr: .word 5, -3, 12, 0, -8, 7, 7, 100, -50, 1

.text
main:
    la   $s0, arr
    li   $s1, 10             # n
    jal  print_array         # antes
    addi $s2, $s1, -1        # i = n-1
b_out:
    beq  $s2, $zero, b_done
    li   $s3, 0              # j
b_in:
    slt  $t0, $s3, $s2
    beq  $t0, $zero, b_onext
    sll  $t1, $s3, 2
    add  $t1, $t1, $s0
    lw   $t2, 0($t1)         # a[j]
    lw   $t3, 4($t1)         # a[j+1]
    slt  $t4, $t3, $t2       # a[j+1] < a[j] (con signo)
    beq  $t4, $zero, b_noswap
    sw   $t3, 0($t1)
    sw   $t2, 4($t1)
b_noswap:
    addi $s3, $s3, 1
    j    b_in
b_onext:
    addi $s2, $s2, -1
    j    b_out
b_done:
    jal  print_array         # despues
    li   $v0, 10
    syscall

# print_array: imprime los $s1 enteros de $s0 separados por espacio
print_array:
    move $s7, $ra
    li   $s4, 0
pa_l:
    slt  $t0, $s4, $s1
    beq  $t0, $zero, pa_end
    sll  $t1, $s4, 2
    add  $t1, $t1, $s0
    lw   $a0, 0($t1)
    jal  print_int
    li   $a0, 32
    li   $v0, 11
    syscall
    addi $s4, $s4, 1
    j    pa_l
pa_end:
    li   $a0, 10
    li   $v0, 11
    syscall
    jr   $s7

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
