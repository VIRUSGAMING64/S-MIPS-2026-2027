# Test sb: escribe bytes en los 4 carriles y comprueba
# Salida esperada: ABCD
        .data
w:      .word 0x11223344

        .text
main:
        la   $s0, w

        # sb 0xAA en offset 0
        addi $t0, $zero, 0xAA
        sb   $t0, 0($s0)
        lbu  $a0, 0($s0)
        addi $a0, $a0, -105        # 0xAA = 170 → 170-105=65 = 'A'
        addi $v0, $zero, 11
        syscall

        # sb 0xBB en offset 1
        addi $t0, $zero, 0xBB
        sb   $t0, 1($s0)
        lbu  $a0, 1($s0)
        addi $a0, $a0, -121        # 0xBB = 187 → 187-121=66 = 'B'
        addi $v0, $zero, 11
        syscall

        # sb 0xCC en offset 2
        addi $t0, $zero, 0xCC
        sb   $t0, 2($s0)
        lbu  $a0, 2($s0)
        addi $a0, $a0, -137        # 0xCC = 204 → 204-137=67 = 'C'
        addi $v0, $zero, 11
        syscall

        # sb 0xDD en offset 3
        addi $t0, $zero, 0xDD
        sb   $t0, 3($s0)
        lbu  $a0, 3($s0)
        addi $a0, $a0, -153        # 0xDD = 221 → 221-153=68 = 'D'
        addi $v0, $zero, 11
        syscall

        addi $v0, $zero, 10
        syscall
