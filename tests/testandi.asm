.text
main:
    lui   $t0, 0xFFFF
    lui   $t1, 0x0F0F
    and   $t2, $t0, $t1        # debería dar 0x0F0F0000

    srl   $t3, $t2, 28
    addi  $a0, $t3, 48         # debe imprimir '0'
    addi  $v0, $zero, 11
    syscall

    addi  $v0, $zero, 10
    syscall
